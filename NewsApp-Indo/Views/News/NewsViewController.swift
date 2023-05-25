//
//  NewsViewController.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import UIKit
import SafariServices
import TinyConstraints
import RxSwift
import RxCocoa
import RxDataSources


// TODO add refreshing feature to every screens
// TODO Subscribe to error and show alarm
// TODO Finish side menu

class NewsViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    let newsCellId = "newsCellId"
    let activityIndicatorView = UIActivityIndicatorView(color: .black)
    let refreshControl = UIRefreshControl()
    
    let viewModel: NewsViewModel
    let disposeBag = DisposeBag()
    
    init(_ viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        configureCollectionView()
        view.addSubview(activityIndicatorView)
        collectionView.refreshControl = refreshControl
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        activityIndicatorView.edgesToSuperview()
        setupBinding()
    }
    
    func setupBinding() {
        viewModel.loading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loadPageTrigger.onNext(())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                dataObserver.onNext(())
            })
            .disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<TopNewsPresentationSection>(configureCell: { [weak self]
            (ds, cv, ip, item) in
            guard let self = self else { fatalError() }
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: self.newsCellId, for: ip) as? NewsCell else { return UICollectionViewCell() }
            cell.news = item
            return cell
        })
        
        
        viewModel.news
            .observeOn(MainScheduler.instance)
            .map({
                items in [TopNewsPresentationSection(items: items)]
            })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
        .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
        .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TopNewsPresentation.self)
            .subscribe(onNext: { [weak self]
                news in
                guard let self = self else { return }
                let detailViewController = DetailNewsViewController()
                detailViewController.news = news
                self.navigationController?.pushViewController(detailViewController, animated: true)
            })
        .disposed(by: disposeBag)
        
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: newsCellId)
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width / 1.2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

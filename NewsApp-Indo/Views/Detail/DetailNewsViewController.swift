//
//  DetailNewsViewController.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//


import UIKit

class DetailNewsViewController: UIViewController {
    var vStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .top
        vStack.distribution = .equalSpacing
        return vStack
    }()
    
    var hStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 2
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        return hStack
    }()
    
    var newsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let newsImage = UIImage(named: "Sample")!
        image.contentMode = .scaleAspectFit
        image.image = newsImage
        return image
    }()
    
    let sourceLabel: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.preferredFont(forTextStyle: .caption2)
        author.adjustsFontForContentSizeCategory = true
        author.textColor = .systemGray
        return author
    }()
    
    let newsTitleLabel: UILabel = {
        let newsTitle = UILabel()
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        newsTitle.lineBreakMode = .byWordWrapping
        newsTitle.numberOfLines = 2
        return newsTitle
    }()
    
    let timeLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.preferredFont(forTextStyle: .caption2)
        date.adjustsFontForContentSizeCategory = true
        date.textColor = .systemGray
        return date
    }()
    
    let newsDescLabel: UILabel = {
        let newsDesc = UILabel()
        newsDesc.translatesAutoresizingMaskIntoConstraints = false
        newsDesc.font = UIFont.preferredFont(forTextStyle: .caption2)
        newsDesc.lineBreakMode = .byWordWrapping
        newsDesc.numberOfLines = 0
        return newsDesc
    }()
    
    let scrollView  = UIScrollView()
    
    var news: TopNewsPresentation? {
        didSet {
            if let news = news {
                if let newsImageUrl = news.urlToImage {
                    newsImageView.load(url: URL(string: newsImageUrl)!, placeholder: UIImage(named: "Sample"))
                }
                let time = news.publishedAt.getTimeAgo()
                newsTitleLabel.text = news.title
                timeLabel.text = time
                sourceLabel.text = news.source
                newsDescLabel.text = news.content
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
        
    }
}

extension DetailNewsViewController {
    func setupViews() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        vStackView.addArrangedSubview(newsImageView)
        vStackView.addArrangedSubview(sourceLabel)
        vStackView.addArrangedSubview(newsTitleLabel)
        vStackView.addArrangedSubview(timeLabel)
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(newsDescLabel)
        
        scrollView.addSubview(vStackView)
        
        view.addSubview(scrollView)
        
    }
    
    private func layout(){
        
        //ScrollView Constraint
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vStackView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
        
        scrollView.contentSize = view.frame.size
        
        // Components Constraint
        NSLayoutConstraint.activate([
            newsDescLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            vStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: newsDescLabel.trailingAnchor, multiplier: 1),
            hStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            sourceLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            newsTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            timeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
        ])
        
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = view.frame.width
        
        let heightLayout = newsImageView.heightAnchor.constraint(equalToConstant: screenWidth)
        heightLayout.isActive = true
        
        if let size = newsImageView.image?.size {
            heightLayout.constant = size.height / size.width * screenWidth // 200 is imageView width
            view.layoutIfNeeded()
        }
    }
    
    
    
}

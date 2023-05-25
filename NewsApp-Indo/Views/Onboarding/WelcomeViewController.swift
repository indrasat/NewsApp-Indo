//
//  WelcomeViewController.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 19/02/23.
//
import UIKit

class WelcomeViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        return titleLabel
    }()
    
    let subtitleLabel : UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        return subtitleLabel
    }()
    
    let startButton : UIButton = {
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        startButton.backgroundColor = .systemBlue
        startButton.layer.cornerRadius = 8
        startButton.addTarget(self, action: #selector(goToMainPage(_:)), for: .primaryActionTriggered)
        return startButton
    }()
    
    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
}

extension WelcomeViewController {
    
        
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(startButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
            
            startButton.widthAnchor.constraint(equalTo: subtitleLabel.widthAnchor),
            startButton.heightAnchor.constraint(equalTo: subtitleLabel.heightAnchor),
        ])
    }
    
    @objc func goToMainPage(_ sender: UIButton){
        UserDefaultsHelper.setData(value: true, key: .isFirstTime)
        let newsViewController = UINavigationController(rootViewController: NewsViewController(container.resolve(NewsViewModel.self)!))
        UIApplication.shared.windows.first?.rootViewController = newsViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
}

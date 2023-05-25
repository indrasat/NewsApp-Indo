//
//  SplashScreenViewController.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 19/02/23.
//

import UIKit



class SplashScreenViewController: UIViewController {
    
    private var splashImageView: UIImageView = {
        let imageView = UIImageView()
        let profile = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = profile
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(splashImageView)
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        splashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        splashImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        splashImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }

}

//
//  AppDelegate.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let container = Container() { container in
        container.register(NewsService.self) { _ in NewsService.init()}
        
        container.register(NewsViewModel.self) { resolver in
            NewsViewModel(resolver.resolve(NewsService.self)!)
        }
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let mainViewController = UINavigationController(rootViewController: NewsViewController(container.resolve(NewsViewModel.self)!))
        let splashScreenViewController = SplashScreenViewController()
        let onBoardingViewController = UINavigationController(rootViewController: OnboardingMainViewController())
        let isFirstTime = UserDefaultsHelper.getData(type: Bool.self, forKey: .isFirstTime)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        if let isFirstTime = isFirstTime {
            window?.rootViewController = splashScreenViewController
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.window?.rootViewController = mainViewController
            }
        } else {
            window?.rootViewController = onBoardingViewController
        }
        
        return true
    }


}


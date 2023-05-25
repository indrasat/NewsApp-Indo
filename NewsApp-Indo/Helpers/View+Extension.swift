//
//  View+Extension.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import UIKit
import RxSwift

private var containerView: UIView!


import UIKit
import Swinject

extension UIViewController {
    
    var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var container: Container {
        appDelegate.container
    }
    
}

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
            let cache = cache ?? URLCache.shared
            let request = URLRequest(url: url)
            
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                self.image = placeholder
                
                URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode, let image = UIImage(data: data) else { return }
                    
                    let cachedData = CachedURLResponse(response: httpResponse, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }.resume()
            }
        }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension UIActivityIndicatorView {
    convenience init(color: UIColor) {
        self.init(style: UIActivityIndicatorView.Style.large)
        self.color = color
        self.hidesWhenStopped = true
    }
}

extension Reactive where Base: UIScrollView {
    public var reachedBottom: Observable<Void> {
        let scrollView = self.base as UIScrollView
        return self.contentOffset.flatMap{ [weak scrollView] (contentOffset) -> Observable<Void> in
            guard let scrollView = scrollView else { return Observable.empty() }
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            let threshold = max(0.0, contentHeight - height)

            return (offsetY > threshold) ? Observable.just(()) : Observable.empty()
        }
    }
}

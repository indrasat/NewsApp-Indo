//
//  UIHelper.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import UIKit

struct UIHelper {

    static func activityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            activityIndicatorView.color = .black
            activityIndicatorView.hidesWhenStopped = true
            return activityIndicatorView
    }
}

//
//  NewsCell.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    var newsImageView: UIImageView = {
        let imageV = UIImageView(frame: .zero)
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius = 10
        imageV.image = UIImage(named: "Sample")
        return imageV
    }()
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    var sourceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var news: TopNewsPresentation? {
        didSet {
            if let news = news {
                if let newsImageUrl = news.urlToImage {
                    newsImageView.load(url: URL(string: newsImageUrl)!, placeholder: UIImage(named: "placeholderNews"))
                }
                let time = news.publishedAt.getTimeAgo()
                headerLabel.text = news.title
                timeLabel.text = time
                sourceLabel.text = news.source
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .systemBackground
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(headerLabel)
        addSubview(newsImageView)
        addSubview(timeLabel)
        let horizontalStackView = UIStackView(arrangedSubviews: [timeLabel, sourceLabel])
        horizontalStackView.distribution = .equalSpacing
        let labelStackView = UIStackView()
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(headerLabel)
        labelStackView.addArrangedSubview(horizontalStackView)
        labelStackView.axis = .vertical

        newsImageView.edgesToSuperview(excluding: .bottom, insets: .init(top: 5, left: 5, bottom: 5, right: 5))
        newsImageView.height(240)
        labelStackView.edgesToSuperview(excluding: .top, insets: .left(5))
        labelStackView.topToBottom(of: newsImageView)
    }
}

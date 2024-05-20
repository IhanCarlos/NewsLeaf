//
//  BannerView.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import UIKit

class BannerView: UIView {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .ds(.logo)
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News leaf"
        label.font = .dsFonts(.serifBold26)
        label.textColor = .ds(.purple)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.serifBold26)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var trendingImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addShadow()
        return image
    }()
    
    lazy var opaqueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.30)
        return view
    }()
    
    lazy var containerTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ds(.purple)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.serifBold16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleTrendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.serifBold16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateTrendingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.maven14)
        label.textColor = .ds(.purple)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var progressTrendingBar: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0.50
        progress.tintColor = .ds(.purple)
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        if titleLabel.text == "" {
            containerTitleView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerView: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(trendingImage)
        addSubview(logoImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(containerTitleView)
        addSubview(authorLabel)
        addSubview(titleTrendingLabel)
        addSubview(dateTrendingLabel)
        addSubview(progressTrendingBar)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            logoImage.widthAnchor.constraint(equalToConstant: 60),
            logoImage.heightAnchor.constraint(equalToConstant: 65),
            
            titleLabel.topAnchor.constraint(equalTo: logoImage.topAnchor, constant: 2),
            titleLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            trendingImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            trendingImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            trendingImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            trendingImage.heightAnchor.constraint(equalToConstant: 220),
            
            containerTitleView.bottomAnchor.constraint(equalTo: trendingImage.bottomAnchor, constant: -10),
            containerTitleView.leftAnchor.constraint(equalTo: authorLabel.leftAnchor, constant: -10),
            containerTitleView.rightAnchor.constraint(equalTo: trendingImage.rightAnchor, constant: -10),
            containerTitleView.heightAnchor.constraint(equalToConstant: 40),
            
            authorLabel.centerYAnchor.constraint(equalTo: containerTitleView.centerYAnchor),
            authorLabel.rightAnchor.constraint(equalTo: containerTitleView.rightAnchor, constant: -10),
            
            titleTrendingLabel.topAnchor.constraint(equalTo: trendingImage.bottomAnchor, constant: 10),
            titleTrendingLabel.leftAnchor.constraint(equalTo: trendingImage.leftAnchor),
            titleTrendingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            dateTrendingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            dateTrendingLabel.topAnchor.constraint(equalTo: titleTrendingLabel.bottomAnchor, constant: 5),
            dateTrendingLabel.heightAnchor.constraint(equalToConstant: 20),
            
            progressTrendingBar.leftAnchor.constraint(equalTo: trendingImage.leftAnchor),
            progressTrendingBar.bottomAnchor.constraint(equalTo: trendingImage.bottomAnchor),
            progressTrendingBar.rightAnchor.constraint(equalTo: trendingImage.rightAnchor),
            progressTrendingBar.heightAnchor.constraint(equalToConstant: 3),
        ])
    }
}

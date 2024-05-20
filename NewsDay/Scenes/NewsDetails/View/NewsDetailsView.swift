//
//  NewsDetailsView.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//
import UIKit

class NewsDetailsView: UIView {
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.dsSystem(.backChevron), for: .normal)
        button.imageView?.tintColor = .ds(.purple)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()

    lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Titulo"
        label.font = .dsFonts(.serifBold16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Autor"
        label.font = .dsFonts(.maven14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var newsDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.maven12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        return image
    }()
    
    lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.maven12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailsView: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(whiteView)
        addSubview(backButton)
        addSubview(newsTitleLabel)
        addSubview(authorLabel)
        addSubview(newsDateLabel)
        addSubview(newsImage)
        addSubview(newsDescriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: topAnchor),
            whiteView.leftAnchor.constraint(equalTo: leftAnchor),
            whiteView.bottomAnchor.constraint(equalTo: centerYAnchor),
            whiteView.rightAnchor.constraint(equalTo: rightAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            newsTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            newsTitleLabel.leftAnchor.constraint(equalTo: backButton.leftAnchor),
            newsTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10),
            authorLabel.leftAnchor.constraint(equalTo: newsTitleLabel.leftAnchor),
            
            newsDateLabel.leftAnchor.constraint(equalTo: authorLabel.rightAnchor, constant: 20),
            newsDateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            
            newsImage.topAnchor.constraint(equalTo: newsDateLabel.bottomAnchor, constant: 5),
            newsImage.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -5),
            newsImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            newsImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 20),
            newsDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            newsDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .ds(.iceWhite)
        
        whiteView.accessibilityIdentifier = "whiteView"
        backButton.accessibilityIdentifier = "backButton"
        newsTitleLabel.accessibilityIdentifier = "newsTitleLabel"
        authorLabel.accessibilityIdentifier = "authorLabel"
        newsDateLabel.accessibilityIdentifier = "newsDateLabel"
        newsImage.accessibilityIdentifier = "newsImage"
        newsDescriptionLabel.accessibilityIdentifier = "newsDescriptionLabel"
    }
}

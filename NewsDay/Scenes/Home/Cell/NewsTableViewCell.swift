//
//  NewsTableViewCell.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: NewsTableViewCell.self)
    
    private lazy var containerElementsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.addShadow()
        return view
    }()
    
    private lazy var containerAuthorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ds(.lightGray)
        view.layer.cornerRadius = 28
        return view
    }()
    
    private lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.maven14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.serifBold16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.maven12)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(data: Article) {
        self.authorLabel.text = data.author
        self.newsTitleLabel.text = data.title
        self.newsDescriptionLabel.text = data.description
        
        if let url = data.urlToImage {
            UIImage.downloadStringImage(from: url) { [weak self] image in
                self?.newsImage.image = image
                self?.newsImage.layer.cornerRadius = 28
                self?.newsImage.clipsToBounds = true
            }
        }
    }
}

extension NewsTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(containerElementsView)
        containerElementsView.addSubview(newsImage)
        containerElementsView.addSubview(containerAuthorView)
        containerElementsView.addSubview(newsImage)
        containerElementsView.addSubview(authorLabel)
        containerElementsView.addSubview(newsTitleLabel)
        containerElementsView.addSubview(newsDescriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerElementsView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerElementsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            containerElementsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            containerElementsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            newsTitleLabel.topAnchor.constraint(equalTo: containerElementsView.topAnchor, constant: 5),
            newsTitleLabel.leftAnchor.constraint(equalTo: containerAuthorView.leftAnchor, constant: 20),
            newsTitleLabel.rightAnchor.constraint(equalTo: containerElementsView.rightAnchor, constant: -20),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            newsImage.topAnchor.constraint(equalTo: containerElementsView.topAnchor),
            newsImage.leftAnchor.constraint(equalTo: containerElementsView.leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: containerElementsView.rightAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 160),
            
            containerAuthorView.leftAnchor.constraint(equalTo: newsImage.leftAnchor),
            containerAuthorView.rightAnchor.constraint(equalTo: newsImage.rightAnchor),
            containerAuthorView.bottomAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 30),
            containerAuthorView.heightAnchor.constraint(equalToConstant: 100),
            
            authorLabel.leftAnchor.constraint(equalTo: containerAuthorView.leftAnchor, constant: 20),
            authorLabel.bottomAnchor.constraint(equalTo: containerAuthorView.bottomAnchor, constant: -7),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: containerAuthorView.bottomAnchor, constant: 10),
            newsDescriptionLabel.leftAnchor.constraint(equalTo: newsTitleLabel.leftAnchor),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: containerElementsView.bottomAnchor),
            newsDescriptionLabel.rightAnchor.constraint(equalTo: newsTitleLabel.rightAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

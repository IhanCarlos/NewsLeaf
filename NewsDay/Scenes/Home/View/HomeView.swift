//
//  HomeView.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import UIKit

class HomeView: UIView {
    
    var bannerHeightConstraint: NSLayoutConstraint!
    var bannerTopConstraint: NSLayoutConstraint!
    var bannerVisibleHeight: CGFloat = 480
    var bannerHiddenHeight: CGFloat = 0
    
    lazy var bannerNews: BannerView = {
        let search = BannerView()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    lazy var searchBar: CustomSearchBar = {
        let search = CustomSearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    lazy var newsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .ds(.iceWhite)
        return table
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .ds(.purple)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(bannerNews)
        addSubview(searchBar)
        addSubview(newsTableView)
        addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        bannerHeightConstraint = bannerNews.heightAnchor.constraint(equalToConstant: bannerVisibleHeight)
        bannerTopConstraint = bannerNews.topAnchor.constraint(equalTo: topAnchor)
        
        NSLayoutConstraint.activate([
            bannerTopConstraint,
            bannerNews.leftAnchor.constraint(equalTo: leftAnchor),
            bannerNews.rightAnchor.constraint(equalTo: rightAnchor),
            bannerHeightConstraint,
            
            searchBar.topAnchor.constraint(equalTo: bannerNews.bottomAnchor, constant: 20),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            newsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            newsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            newsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 40),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .ds(.iceWhite)
        newsTableView.contentInsetAdjustmentBehavior = .never
        
        newsTableView.accessibilityIdentifier = "newsTableView"
        loadingIndicator.accessibilityIdentifier = "loadingIndicator"
        searchBar.searchTextField.accessibilityIdentifier = "searchBar"
        bannerNews.accessibilityIdentifier = "bannerNews"

    }
}

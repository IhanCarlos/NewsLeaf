//
//  NewsDetailsViewController.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var viewModel: NewsDetailsViewModel
    private let detailsView = NewsDetailsView()
    
    init(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observableStates()
    }
    
    func observableStates() {
        viewModel.observeStates { [weak self] state in
            switch state {
            case .setupView(let article):
                self?.setupData(data: article)
            }
        }
    }
    
    private func setupView() {
        detailsView.backButton.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
    }
    
    @objc func backScreen() {
        viewModel.backScreen()
    }
    
    private func setupData(data: Article) {
        detailsView.newsTitleLabel.text = data.title
        detailsView.authorLabel.text = data.author
        detailsView.newsDateLabel.text = data.publishedAt
        detailsView.newsDescriptionLabel.text = data.description
        
        if let url = data.urlToImage {
            UIImage.downloadStringImage(from: url) { [weak self] image in
                self?.detailsView.newsImage.image = image
                self?.detailsView.newsImage.layer.cornerRadius = 28
                self?.detailsView.newsImage.clipsToBounds = true
            }
        }
    }
}

//
//  ViewController.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModelProtocol
    
    private var currentPageIndex = 0
    private var timer: Timer?
    private var bannerChangeInterval: TimeInterval = 10
    private var timeElapsed: TimeInterval = 0
    
    private var bannerHeightConstraint: NSLayoutConstraint!
    private var bannerVisibleHeight: CGFloat = 100
    private var bannerHiddenHeight: CGFloat = 0
    
    public let homeView = HomeView()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
        configureSearchBar()
        observableStates()
        configureDateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchHedlineNews()
        viewModel.fetchTopHedline()
        startTimer()
    }
    
    func observableStates() {
        viewModel.observeStates { [weak self] state in
            switch state {
            case .loading:
                self?.homeView.loadingIndicator.startAnimating()
            case .success:
                DispatchQueue.main.async {
                    self?.homeView.loadingIndicator.stopAnimating()
                    self?.homeView.newsTableView.reloadData()
                }
            case .failure:
                break
            case .reloadData:
                self?.homeView.newsTableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        homeView.loadingIndicator.startAnimating()
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureTableView() {
        homeView.newsTableView.delegate = self
        homeView.newsTableView.dataSource = self
        homeView.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    private func configureSearchBar() {
        homeView.searchBar.searchTextField.delegate = self
    }
    
    private func configureDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        homeView.bannerNews.dateLabel.text = dateString
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func nextBanner() {
        currentPageIndex += 1
        if currentPageIndex == viewModel.numberBanner {
            currentPageIndex = 0
        }
        
        if let banner = viewModel.banner?[currentPageIndex] {
            
            if let url = banner.urlToImage {
                UIImage.downloadStringImage(from: url) { [weak self] image in
                    DispatchQueue.main.async {
                        self?.homeView.bannerNews.trendingImage.image = image
                        self?.homeView.bannerNews.trendingImage.layer.cornerRadius = 28
                    }
                }
            }
            homeView.bannerNews.authorLabel.text = banner.author
            homeView.bannerNews.titleTrendingLabel.text = banner.title
            homeView.bannerNews.dateTrendingLabel.text = banner.publishedAt
        }
        timeElapsed = 0
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc private func updateProgress() {
        timeElapsed += 0.1
        
        let progress = Float(timeElapsed / bannerChangeInterval)
        homeView.bannerNews.progressTrendingBar.setProgress(progress, animated: true)
        
        if timeElapsed >= bannerChangeInterval {
            nextBanner()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articles = viewModel.articles else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.setupCell(data: articles[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let article = viewModel.articles?[indexPath.row] else { return }
        
        self.viewModel.goToDetails(article: article)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let bannerVisibleHeight: CGFloat = 480
        
        if offsetY > 0 {
            let newHeight = max(0, bannerVisibleHeight - offsetY)
            homeView.bannerHeightConstraint.constant = newHeight
            
            if newHeight == 0 {
                homeView.bannerTopConstraint.constant = -bannerVisibleHeight
            } else {
                homeView.bannerTopConstraint.constant = 0
            }
        } else {
            homeView.bannerHeightConstraint.constant = bannerVisibleHeight - offsetY
            homeView.bannerTopConstraint.constant = 0
        }

        UIView.animate(withDuration: 0.25) {
            self.homeView.layoutIfNeeded()
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              let range = Range(range, in: currentText) else {
            return true
        }
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        viewModel.filterItems(with: updatedText)
        return true
    }
}

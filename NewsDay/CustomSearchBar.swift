//
//  CustomSearchBar.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import UIKit

class CustomSearchBar: UIView {

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.dsSystem(.magnifyglass), for: .normal)
        button.imageView?.tintColor = .black.withAlphaComponent(0.40)
        return button
    }()

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.placeholder = "O que você procura?"
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSearchBar: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(searchButton)
        addSubview(searchTextField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            searchTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
        layer.cornerRadius = 12
        addShadow()
    }
}

//
//  ViewCodeProtocol.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import Foundation

protocol ViewCodeType {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCodeType {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    func setupAdditionalConfiguration() {}
}

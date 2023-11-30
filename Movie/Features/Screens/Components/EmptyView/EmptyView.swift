//
//  EmptyView.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import UIKit

final class EmptyView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.configureSubviews()
        self.configureConstraints()
    }
    
    public func updateView(with configuration: EmptyViewConfiguration) {
        self.titleLabel.text = configuration.title
        self.descriptionLabel.text = configuration.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (corder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo:
            self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo:
            self.centerYAnchor),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
}

//
//  MovieListCellView.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import UIKit

struct MovieListCellViewConfiguration {
    let movieTitle: String
    let movieYear: String
    let imageURL: URL
}

final class MovieListCellView: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private var labelsStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 20)
      return label
   }()
   
   private let movieYearLabel: UILabel = {
     let label = UILabel()
     label.font = UIFont.systemFont(ofSize: 16)
     label.textColor = .lightGray
     return label
  }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureSubviews()
        self.configureSubviewsConstraints()
        self.configureAdditionalBehaviors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with configuration: MovieListCellViewConfiguration) {
        movieTitleLabel.text = configuration.movieTitle
        movieYearLabel.text = configuration.movieYear
        posterImageView.downloaded(from: configuration.imageURL)
        
    }
}

extension MovieListCellView {
    
    func configureSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(labelsStackView)

        labelsStackView.addArrangedSubview(movieTitleLabel)
        labelsStackView.addArrangedSubview(movieYearLabel)
    }
    
    func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            posterImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configureAdditionalBehaviors() {
        accessoryType = .disclosureIndicator
    }
}

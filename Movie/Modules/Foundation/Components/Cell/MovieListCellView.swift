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
}

final class MovieListCellView: UITableViewCell {
    
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieYearLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
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
    }
}

extension MovieListCellView {
    
    func configureSubviews() {
        addSubview(stackView)
    }
    
    func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        ])
    }
    
    func configureAdditionalBehaviors() {
        accessoryType = .disclosureIndicator
    }
}

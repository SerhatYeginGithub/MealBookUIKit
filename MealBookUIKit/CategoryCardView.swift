//
//  CategoryCardView.swift
//  MealBookUIKit
//
//  Created by serhat on 3.10.2024.
//

import UIKit

class CategoryCardView: UIView {
    private let cardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "panda"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 15
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String,imageURL: String) {
        super.init(frame: .zero)
        self.setUp(text: text, image: imageURL)
    }
    
    private func setUp(text: String, image: String) {
        self.addSubview(cardImageView)
        self.addSubview(cardLabel)
        cardLabel.text = text
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardLabel.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -10),
            cardLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor),
            cardLabel.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor)
        ])
    }
    
}

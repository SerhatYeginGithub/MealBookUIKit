//
//  CategoryCollectionViewCell.swift
//  MealBookUIKit
//
//  Created by serhat on 3.10.2024.
//

import UIKit
import SDWebImage

final class CategoryCollectionViewCell: UICollectionViewCell {
    //MARK: - PROPERTIES
    static let identifier = "CategoryCollectionViewCell"
    
    //MARK: - UI ELEMENTS
    private lazy var  categoryImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "food-placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
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
        super.init(frame: frame)
        setUpCell()
    }
    
    init( ) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - HELPER FUNCTIONS
extension CategoryCollectionViewCell {
    private func setUpCell() {
        self.layer.shadowRadius = 4
        self.addSubview(categoryImageView)
        self.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: -10),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImageView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImageView.trailingAnchor)
        ])
    }
    
    public func setCategory(imageURL: String, name: String) {
        categoryLabel.text = name
        categoryImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
    }
}

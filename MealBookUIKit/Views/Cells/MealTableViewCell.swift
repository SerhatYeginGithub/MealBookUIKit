//
//  MealTableViewCell.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    static let identifier = "MealTableViewCell"
    
    //MARK: - UI ELEMENTS
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var mealNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - LIFE CYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - HELPER FUNCTIONS
extension MealTableViewCell {
    
    private func setUpCell() {
        
        self.addSubview(mealImageView)
        self.addSubview(mealNameLabel)
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mealImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mealImageView.widthAnchor.constraint(equalToConstant: 100),
            mealImageView.heightAnchor.constraint(equalTo: mealImageView.widthAnchor),
            mealNameLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 10),
            mealNameLabel.topAnchor.constraint(equalTo: mealImageView.topAnchor),
            mealNameLabel.centerYAnchor.constraint(equalTo: mealImageView.centerYAnchor),
            mealNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)
        ])
    }
    
    public func setMealItem(imageURL: String, mealName: String) {
        mealNameLabel.text = mealName
        mealImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "food-placeholder"),completed: nil)
      
    }
    
}

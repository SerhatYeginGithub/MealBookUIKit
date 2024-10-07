//
//  HomeViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 3.10.2024.
//

import UIKit

protocol IHomeView: AnyObject {
    func showCategories()
    func showActivityIndicator()
    func completed()
}

class HomeViewController: UIViewController {
    
    //MARK: - PROPERTIES
    private let vm = HomeViewModel()
    
    //MARK: - UI ELEMENTS
    private let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        vm.setDelegate(output: self)
        configureHomeCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
//MARK: - Configure Functions
extension HomeViewController {
    func configureHomeCollectionView() {
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        view.addSubview(homeCollectionView)
        NSLayoutConstraint.activate([
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

//MARK: - UITableView Delegate, UITableView DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = vm.categories[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        cell.setCategory(imageURL: item.strCategoryThumb, name: item.strCategory)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = vm.categories[indexPath.row]
        let destinationVC = MealListViewController()
        destinationVC.category = item.strCategory
        navigationController?.pushViewController(destinationVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension HomeViewController: IHomeView {
    func completed() {
        self.removeActivity()
    }
    
    func showActivityIndicator() {
        self.showActivity()
    }
    
    
    func showCategories() {
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
        
    }
    
    
}


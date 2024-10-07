//
//  SearchResultViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 5.10.2024.
//

import UIKit


final class SearchResultViewController: UIViewController {
    //MARK: - PROPERTIES
    var meals: mealList = []
    
    //MARK: - UI ELEMENTS
    public lazy var searchTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        table.rowHeight = 125
        return table
    }()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTableView.frame = view.bounds
    }
}

//MARK: - HELPER FUNCTIONS
extension SearchResultViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        configureSearchTableView()
    }
    func configureSearchTableView() {
        view.addSubview(searchTableView)
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
}
//MARK: - UITABLEVIEW DELEGATE - UITABLEVIEW DATASOURCE
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = meals[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell()
        }
        cell.setMealItem(imageURL: item.strMealThumb, mealName: item.strMeal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = meals[indexPath.row].idMeal
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = MealDetailViewController()
        destination.mealId = id
        navigationController?.pushViewController(destination, animated: true)
    }
    
}

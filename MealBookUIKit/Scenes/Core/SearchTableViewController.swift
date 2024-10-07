//
//  SearchTableViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 5.10.2024.
//


import UIKit

protocol ISearchView: AnyObject {
    
    func showResults()
    func showLoadingView()
    func dismissLoadingView()
}

final class SearchTableViewController: UITableViewController {
    
    //MARK: - PROPERTIES
    private let vm = SearchViewModel()
    
    //MARK: - UI ELEMENTS
    private lazy var  searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search for a Meal"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return vm.meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.meals[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {return UITableViewCell()}
        cell.setMealItem(imageURL: item.strMealThumb, mealName: item.strMeal)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let mealId =  vm.meals[indexPath.row].idMeal
        let destination = MealDetailViewController()
        destination.mealId = mealId
        navigationController?.pushViewController(destination, animated: true)
    }
    
}

//MARK: - HELPER FUNCTIONS

extension SearchTableViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        tableView.rowHeight = 125
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        vm.setDelegate(self)
    }
    
}


extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            vm.meals.removeAll()
            showResults()
            return
        }
        
        vm.debounceSearchText(text)
        
    }
    
    
}

extension SearchTableViewController: ISearchView {
    
    func showResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoadingView() {
        self.showActivity()
    }
    
    func dismissLoadingView() {
        self.removeActivity()
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: SearchTableViewController())
}


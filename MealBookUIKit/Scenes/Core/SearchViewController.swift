//
//  SearchViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 3.10.2024.
//

import UIKit

protocol ISearchView: AnyObject{
    func reloadTable(mealList: mealList?)
    func showLoadingView()
    func dismissLoadingView()
}
class SearchViewController: UIViewController {
    
    //MARK: - PROPERTIES
    private let vm = SearchViewModel()
    private let resultVC = SearchResultViewController()
    //MARK: - UI ELEMENTS
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: resultVC)
        controller.searchBar.placeholder = "Search for a Meal"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

//MARK: - HELPER FUNCTIONS
extension SearchViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        configureSearchController()
        configureViewModel()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
    }
    func configureViewModel() {
        vm.setDelegate(self)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else {return}
        vm.debounceSearchText(text)
        }
    }
    
extension SearchViewController: ISearchView {
    func reloadTable(mealList: mealList?) {
        guard let meals = mealList else {return}
        resultVC.meals = meals
        DispatchQueue.main.async { self.resultVC.searchTableView.reloadData() }
    }
    
    func showLoadingView() {
        resultVC.showActivity()
    }
    
    func dismissLoadingView() {
        resultVC.removeActivity()
    }
    
    
}

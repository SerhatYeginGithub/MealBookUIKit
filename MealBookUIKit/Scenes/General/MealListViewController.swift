//
//  MealListViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import UIKit
protocol IMealListView: AnyObject{
    func showMealList()
    func showLoadingView()
    func dismissLoadingView()
}
final class MealListViewController: UIViewController {
    var category: String?
    private let vm = MealListViewModel()
    
    private lazy var mealTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 125
        table.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTableView()
        vm.setDelegate(self)
        vm.setCategoryName(category)
        Task { await vm.fetchMealList()}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mealTableView.frame = view.bounds
    }
    
}

extension MealListViewController {
    func setUpTableView() {
        title = category
        navigationController?.navigationBar.prefersLargeTitles = true
        mealTableView.dataSource = self
        mealTableView.delegate = self
        view.addSubview(mealTableView)
    }
}

//MARK: - UITableView Delagate , UITableViewDataSource
extension MealListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.mealList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell()
        }
        cell.setMealItem(imageURL: item.strMealThumb, mealName: item.strMeal)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = vm.mealList[indexPath.row]
        let destination = MealDetailViewController()
        destination.mealId = item.idMeal
        tableView.deselectRow(at: indexPath, animated: true)
        destination.title = item.strMeal
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
}

extension MealListViewController: IMealListView {
    func showLoadingView() {
        self.showActivity()
    }
    
    func dismissLoadingView() {
        self.removeActivity()
    }
    
    func showMealList() {
        DispatchQueue.main.async{
            self.mealTableView.reloadData()
        }
    }
}

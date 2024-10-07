//
//  MealListViewModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

protocol IMealListViewModel {
    var category: String { get set }
    func fetchMealList() async
    var mealList: mealList { get }
    var delegate: IMealListView? { get}
    func setDelegate(_ output: IMealListView)
    func setCategoryName(_ category: String?)
}

final class MealListViewModel {
    weak var delegate: (any IMealListView)?
    var category: String = ""
    var mealList: mealList  = []
    
}

extension MealListViewModel: IMealListViewModel {
    func setCategoryName(_ category: String?) {
        guard let category = category else{ return }
        self.category = category
    }
    
  
    @MainActor
    func fetchMealList() async {
        delegate?.showLoadingView()
        defer {delegate?.dismissLoadingView()}
        do {
            let response = try await NetworkingManager.shared.request(type: Meal.self, endpoint: Endpoint.mealListUrl + category)
            self.mealList = response.meals
            self.delegate?.showMealList()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setDelegate(_ output: any IMealListView) {
        self.delegate = output
    }
    
}

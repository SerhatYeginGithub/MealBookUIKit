//
//  MealDetailViewModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

protocol IMealDetailViewModel {
    var mealId: String { get set }
    var mealInfo: MealInfo { get set }
    var delegate: IMealDetailView? { get  }
    func fetchMealDetail() async
    func setMealId(_ id: String?)
    func setDelegate(_ output: IMealDetailView)
}

final class MealDetailViewModel {
    var mealId: String = ""
    var mealInfo: MealInfo = []
    weak var delegate: (any IMealDetailView)?
   
}

//MARK: - IMEALDETAILVIEWMODEL
extension MealDetailViewModel: IMealDetailViewModel {
    
    func setDelegate(_ output: any IMealDetailView) {
        self.delegate = output
    }
    
    
    func setMealId(_ id: String?) {
        guard let id = id else {return}
        self.mealId = id
    }
    
    
    @MainActor
    func fetchMealDetail() async {
        delegate?.showLoadingView()
        defer { delegate?.dismissLoadingView() }
        do {
            let response = try await NetworkingManager.shared.request(type: MealDetail.self, endpoint: Endpoint.mealDetailUrl + mealId)
            self.mealInfo = response.meals
            delegate?.setMeal(title: mealInfo.first?.strMeal, image: mealInfo.first?.strMealThumb, description: mealInfo.first?.strInstructions)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

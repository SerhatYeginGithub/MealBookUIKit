//
//  HomeViewModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

protocol IHomeViewModel {
    var delegate: IHomeView? { get }
    func fetchCategories() async
    var categories: categoryList { get }
    func setDelegate(output: IHomeView)
}

final class HomeViewModel: IHomeViewModel {
    weak var delegate: IHomeView?
    var categories: categoryList = []
    
    init() {
        Task { await fetchCategories() }
    }
    
    func setDelegate(output: any IHomeView) {
        self.delegate = output
    }
    
    @MainActor
    func fetchCategories() async {
        delegate?.showActivityIndicator()
        defer { delegate?.completed()}
        do {
            let response = try await NetworkingManager.shared.request(type: Category.self, endpoint: Endpoint.categoryUrl)
            self.categories = response.categories
            delegate?.showCategories()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    

    
}

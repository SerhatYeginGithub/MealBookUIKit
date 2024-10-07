//
//  SearchViewModel.swift
//  MealBookUIKit
//
//  Created by serhat on 5.10.2024.
//

import Foundation
import Combine

protocol ISearchViewModel {
    var debouncedText: String { get set }
    var delegate: ISearchView? { get set }
    var meals: MealInfo { get set }
    func fetchSearchQuery(with query: String) async
    func setDelegate(_ output: ISearchView)
}

final class SearchViewModel {
    
    weak var delegate: (any ISearchView)?
    var meals: MealInfo = []
    var debouncedText: String = ""
    private var debounceTimer: AnyCancellable?
}

extension SearchViewModel: ISearchViewModel {
    
    func fetchSearchQuery(with query: String) async {
        print("Çalıştı")
        meals.removeAll()
        delegate?.showLoadingView()
        defer { delegate?.dismissLoadingView() }
        do {
            let response = try await NetworkingManager.shared.request(type: MealDetail.self, endpoint: Endpoint.searchUrl + query)
            self.meals = response.meals
            delegate?.showResults()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setDelegate(_ output: any ISearchView) {
        self.delegate = output
    }
    
    
}

extension SearchViewModel {
    
    func debounceSearchText(_ text: String) {
      
       debounceTimer?.cancel()
        
       debounceTimer = Just(text)
           .delay(for: .milliseconds(500), scheduler: RunLoop.main)
           .sink { debouncedText in
               
               self.debouncedText = debouncedText
               Task {
                   await self.fetchSearchQuery(with: debouncedText)
               }
           }
   }
}

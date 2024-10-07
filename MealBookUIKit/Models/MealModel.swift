//
//  MealModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

// MARK: - Meal
struct Meal: Codable{
    let meals: [MealElement]
}

// MARK: - MealElement
struct MealElement: Codable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

typealias mealList = [MealElement]



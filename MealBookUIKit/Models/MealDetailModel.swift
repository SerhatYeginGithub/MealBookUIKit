//
//  MealDetailModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

// MARK: - Meal Detail
struct MealDetail: Codable, Hashable{
    let meals: [MealDetailElement]
}

// MARK: - Meal Detail Element
struct MealDetailElement: Codable, Hashable {
    let idMeal, strMeal: String
    let strCategory, strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15: String?
    let strIngredient16, strIngredient17, strIngredient18, strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4: String?
    let strMeasure5, strMeasure6, strMeasure7, strMeasure8: String?
    let strMeasure9, strMeasure10, strMeasure11, strMeasure12: String?
    let strMeasure13, strMeasure14, strMeasure15: String?
    let strMeasure16, strMeasure17, strMeasure18, strMeasure19: String?
    let strMeasure20: String?
}


typealias MealInfo =  [MealDetailElement]

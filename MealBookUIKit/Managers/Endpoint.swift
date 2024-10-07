//
//  Endpoint.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation


enum Endpoint{
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    static let categoryUrl = baseUrl + "categories.php"
    static let mealListUrl = baseUrl + "filter.php?c="
    static let mealDetailUrl = baseUrl + "lookup.php?i="
    static let searchUrl = baseUrl + "search.php?s="
}

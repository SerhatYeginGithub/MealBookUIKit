//
//  CategoryModel.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

// MARK: - Category
struct Category: Codable, Hashable {
    let categories: [CategoryElement]
}

// MARK: - CategoryElement
struct CategoryElement: Codable, Hashable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

typealias categoryList = [CategoryElement]

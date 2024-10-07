//
//  NetworkingError.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation

enum NetworkingError: String, Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

//
//  NetworkingManager.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import Foundation


final class NetworkingManager {
    
    static let shared = NetworkingManager()
    private init() {}
    
    func request<T: Decodable>(type: T.Type, endpoint: String) async throws -> T{
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse,(200...300) ~= response.statusCode else {
            throw NetworkingError.invalidResponse
        }
       
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(T.self, from: data)
        
        return decodedData
    }
}

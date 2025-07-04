//
//  NetworkService.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation


class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://fakestoreapi.com"
    
    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}

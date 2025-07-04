//
//  NetworkServiceProtocol.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation


protocol NetworkServiceProtocol {
    func fetchProducts() async throws -> [Product]
}





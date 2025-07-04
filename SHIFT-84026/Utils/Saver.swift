//
//  Saver.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 03.07.2025.
//

import SwiftUI


struct Saver {
    static func save<T: Encodable>(_ data: T, forKey key: String) {
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.setValue(encodedData, forKey: key)
        }
    }
    
    static func load<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        guard
            let encodedData = UserDefaults.standard.data(forKey: key),
            let data = try? JSONDecoder().decode(type, from: encodedData)
        else {
            return nil
        }
        return data
    }
}

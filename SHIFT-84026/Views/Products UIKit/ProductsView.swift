//
//  ProductsView.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import SwiftUI


struct ProductsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let productsVC = ProductsViewController()
        let navController = UINavigationController(rootViewController: productsVC)
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {

    }
}


#Preview {
    ProductsView()
}

//
//  MainViewModel.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//


final class ProductsViewModel {
    var products: [Product] = []
    var isLoading = false
    var error: Error?
    var showGreeting = true
    
    private var networkService = NetworkService()
    private var sessionService = SessionService()
    
    var greetingMessage: String {
        guard let user = sessionService.currentUser else { return "Hello!" }
        return "Hello, \(user.firstName) \(user.lastName)!"
    }
    
    func fetchProducts() async {
        isLoading = true
        error = nil
        
        do {
            products = try await networkService.fetchProducts()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func logout() {
        sessionService.clearSession()
    }
    
    func updateSessionService() {
        sessionService = SessionService()
    }
}

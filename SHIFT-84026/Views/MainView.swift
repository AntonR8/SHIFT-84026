//
//  MainView.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 03.07.2025.
//

import SwiftUI

struct MainView: View {
    @AppStorage("userIsRegistered") var userIsRegistered: Bool = false
    
    var body: some View {
        if userIsRegistered {
            ProductsView()
        } else {
            RegistrationView(sessionService: SessionService())
        }
    }
}

#Preview {
    MainView()
}

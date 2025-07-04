//
//  HideKeyboardOnScroll.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import SwiftUI


extension View {
    func hideKeyboardOnScroll() -> some View {
        self.gesture(
            DragGesture().onChanged { _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        )
    }
}

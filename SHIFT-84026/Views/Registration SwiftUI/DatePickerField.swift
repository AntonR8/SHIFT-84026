//
//  DatePickerField.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import SwiftUI


struct DatePickerField: View {
    let title: String
    @Binding var date: Date
    let isValid: Bool
    let errorMessage: String
    @Binding var continueButtonTapped: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.leading, 32)
            
            DatePicker(
                "Выберите дату",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.compact)
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(.secondary.opacity(0.1))
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color.secondary, lineWidth: 0.3)
            }
            
            if !isValid {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(continueButtonTapped ? .red : .secondary)
                    .padding(.leading, 32)
            }
        }
        .padding(.bottom)
    }
}


#Preview {
    VStack(alignment: .leading) {
        DatePickerField(title: "Birth Date", date: .init(projectedValue: .constant(Date())), isValid: false, errorMessage: RegistrationError.invalidBirthDate.errorDescription, continueButtonTapped: .constant(true))
    }
            .padding()
}

//
//  text_field_widget.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import SwiftUI

struct TextFieldWidget: View {
    @Binding var text: String
    var placeholder: String = "Username"

    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(UIColor.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color.gray.opacity(0.4), lineWidth: 1.5)
            )
            .cornerRadius(12)
            .shadow(color: isFocused ? Color.blue.opacity(0.2) : .clear, radius: 4, x: 0, y: 2)
            .focused($isFocused)
            .padding(.horizontal)
    }
}


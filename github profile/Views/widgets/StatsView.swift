//
//  SwiftUIView.swift
//  github profile
//
//  Created by oussama berhili on 13/5/2025.
//

import SwiftUI

struct StatsView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.headline)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

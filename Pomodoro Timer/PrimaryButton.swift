//
//  PrimaryButton.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 27/10/2024.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, maxHeight: 56)
                .foregroundColor(.white)
                .background(
                    ZStack {
                        Color(red: 1, green: 0, blue: 0) // Button background color
                        // Inner shadow
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(Color(red: 0.92, green: 0, blue: 0), lineWidth: 4) // Border color and width
                            .shadow(color: Color(red: 0.92, green: 0, blue: 0), radius: 0, x: 0, y: -4) // Inner shadow settings
                            .clipShape(RoundedRectangle(cornerRadius: 999))
                            .blendMode(.normal) // Overlay blend mode for inner shadow effect
                    }
                )
                .cornerRadius(99)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .inset(by: 1)
                        .stroke(Color(red: 0.92, green: 0, blue: 0), lineWidth: 2)
                )
        }
    }
}

#Preview {
    PrimaryButton(title: "START TIMER") {
        print("Button Tapped")
    }
}

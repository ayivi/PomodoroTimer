//
//  SecondaryButton.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 27/10/2024.
//

import SwiftUI

struct SecondaryButton: View {
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
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(99)
                .shadow(color: Color(red: 0.9, green: 0.9, blue: 0.9), radius: 0, x: 0, y: 2)
                .overlay(
                RoundedRectangle(cornerRadius: 999)
                .inset(by: 1)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 2)
                )
        }
    }
}

#Preview {
    SecondaryButton(title: "START TIMER") {
        print("Button Tapped")
    }
}

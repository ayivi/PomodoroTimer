//
//  TimerDisplayView.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 02/11/2024.
//

import SwiftUI

struct TimerDisplayView: View {
    var timeRemaining: Int
    
    var body: some View {
        HStack(spacing: 8) {
            // Minutes
            VStack(spacing: 4) {
                Text(formatMinutes(timeRemaining))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundColor(.black)
                Text("MIN")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .cornerRadius(16)
            .shadow(color: Color(red: 0.9, green: 0.9, blue: 0.9), radius: 0, x: 0, y: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 1.5)
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 3)
            )
            
            Text(":")
                .font(.system(size: 48, weight: .bold, design: .monospaced))
            
            // Seconds
            VStack {
                Text(formatSeconds(timeRemaining))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundColor(.black)
                Text("SEC")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .cornerRadius(16)
            .shadow(color: Color(red: 0.9, green: 0.9, blue: 0.9), radius: 0, x: 0, y: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 1.5)
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 3)
            )
        }
    }
    
    // Helper functions
    func formatMinutes(_ seconds: Int) -> String {
        let minutes = seconds / 60
        return String(format: "%02d", minutes)
    }
    
    func formatSeconds(_ seconds: Int) -> String {
        let seconds = seconds % 60
        return String(format: "%02d", seconds)
    }
}

#Preview {
    TimerDisplayView(timeRemaining: 300)
}

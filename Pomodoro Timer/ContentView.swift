//
//  ContentView.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 22/10/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var navigateToPomodoro = false // State to control navigation
    @State private var navigateBackToPomodoro = false // New state to detect return

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black // Sets the background color to black
                    .ignoresSafeArea()
                
                VStack {
                    HStack(alignment: .center, spacing: 4) {
                        HStack(alignment: .center) {
                            Text ("POMODORO")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .cornerRadius(999)
                        .shadow(color: Color(red: 0.9, green: 0.9, blue: 0.9), radius: 0, x: 0, y: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 999)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                        )
                        
                        HStack(alignment: .center) {
                            Text ("BREAK")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .cornerRadius(99)
                    }
                    .padding(4)
                    .cornerRadius(999)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                    )
                    
                    Spacer()
                    
                    // Show TimerDisplayView with 25 minutes (1500 seconds)
                    TimerDisplayView(timeRemaining: 1500)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        PrimaryButton(title: "START POMODORO") {
                            navigateToPomodoro = true // Trigger navigation
                        }
                    }
                    .frame(width: 207)
                    .padding(.bottom, 20)
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(
                    Color(red: 0.98, green: 0.98, blue: 0.98)
                        .clipShape(
                            RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 40)
                        )
                        .clipShape(
                            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 24)
                        )
                )
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            .navigationDestination(isPresented: $navigateToPomodoro) {
                PomodoroTimerView(navigateBackToContent: $navigateBackToPomodoro)
            }
            .onChange(of: navigateBackToPomodoro) { newValue in
                if newValue {
                    navigateToPomodoro = false // Dismiss PomodoroTimerView
                    navigateBackToPomodoro = false // Reset for future use
                }
            }
        }
    }
}

// Custom shape to apply corner radius to specific corners
struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


#Preview {
    ContentView()
}

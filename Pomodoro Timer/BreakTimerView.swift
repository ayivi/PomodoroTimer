//
//  BreakTimerView.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 02/11/2024.
//

import SwiftUI

struct BreakTimerView: View {
    @Binding var navigateBackToPomodoro: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var timeRemaining: Int = 300 // 5 minutes in seconds
    @State private var timerActive: Bool = true
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            Color.black // Sets the background color to black
                .ignoresSafeArea()

            VStack {
                VStack {
                    HStack(alignment: .center, spacing: 4) {
                        HStack(alignment: .center) {
                            Text ("POMODORO")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .cornerRadius(99)

                        HStack(alignment: .center) {
                            Text ("BREAK")
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
                    }
                    .padding(4)
                    .cornerRadius(999)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                    )

                    Spacer()

                    TimerDisplayView(timeRemaining: timeRemaining)

                    Spacer()

                    HStack(spacing: 12) {
                        // Tertiary Button - End
                        TertitaryButtton(title: "END") {
                            endBreakAndReturnToContent()
                        }

                        // Secondary Button - Pause/Resume Timer
                        SecondaryButton(title: timerActive ? "PAUSE" : "RESUME") {
                            timerActive.toggle()
                            if timerActive {
                                startBreakTimer() // Resume timer if active
                            } else {
                                timer?.invalidate() // Pause timer if inactive
                            }
                        }

                        // Primary Button - Skip to Pomodoro
                        PrimaryButton(title: "SKIP") {
                            endBreakAndGoToPomodoro()
                        }
                    }
                    .padding(.bottom, 20)
                    .onAppear {
                        startBreakTimer()
                    }
                    .onDisappear {
                        timer?.invalidate()
                    }
                }
                .navigationBarBackButtonHidden(true) // Hides the back button in BreakTimerView
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
    }

    func startBreakTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                endBreakAndGoToPomodoro() // Automatically end break when timer reaches zero
            }
        }
    }

    func endBreakAndGoToPomodoro() {
        timer?.invalidate()
        navigateBackToPomodoro = true // Navigate to PomodoroTimerView
    }

    func endBreakAndReturnToContent() {
        timer?.invalidate() // Stop the timer
        dismiss() // Dismiss BreakTimerView to return to ContentView
    }
}


#Preview {
    BreakTimerView(navigateBackToPomodoro: .constant(false))
}

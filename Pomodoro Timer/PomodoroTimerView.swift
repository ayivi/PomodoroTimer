//
//  PomodoroTimerView.swift
//  Pomodoro Timer
//
//  Created by Ayivi on 02/11/2024.
//

import SwiftUI

struct PomodoroTimerView: View {
    @Binding var navigateBackToContent: Bool // Binding to return to ContentView
    @State private var timeRemaining: Int = 1500 // 25 minutes in seconds
    @State private var timerActive: Bool = false
    @State private var timerPaused: Bool = false
    @State private var timer: Timer? = nil
    @State private var navigateToBreak = false // Navigation trigger
    
    var body: some View {
        NavigationStack {
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
                        
                        TimerDisplayView(timeRemaining: timeRemaining)
                        
                        Spacer()
                        
                        // Timer Control Buttons
                        VStack(alignment: .leading) {
                            if timerActive {
                                HStack(spacing: 12) {
                                    // Tertiary Button - End
                                    TertitaryButtton(title: "END") {
                                        endPomodoro() // End the countdown and return to ContentView
                                    }
                                    
                                    // Secondary Button - Pause/Resume
                                    SecondaryButton(title: timerPaused ? "RESUME" : "PAUSE") {
                                        pauseTimer()
                                    }
                                    
                                    // Primary Button - Break
                                    PrimaryButton(title: "BREAK") {
                                        navigateToBreak = true // Trigger navigation to break view
                                    }
                                }
                            } else {
                                PrimaryButton(title: "START TIMER") {
                                    startPomodoro()
                                }
                                .frame(width: 207)
                            }
                        }
                        .padding(.bottom, 20)
                        .onDisappear {
                            timer?.invalidate() // Stop timer when view disappears
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(isPresented: $navigateToBreak) {
                        BreakTimerView(navigateBackToPomodoro: $navigateToBreak)
                    }
                    .task(id: navigateToBreak) {
                        // Reset the Pomodoro timer when returning from break
                        if !navigateToBreak {
                            startPomodoro()
                        }
                    }
                    .onAppear {
                        if !timerActive {
                            startPomodoro() // Start timer on appear if it's not already running
                        }
                    }
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
    }
    
    func startPomodoro() {
        timeRemaining = 1500 // Reset to 25 minutes
        timerActive = true
        timerPaused = false // Ensure timer is not paused
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerActive = false
                navigateToBreak = true // Automatically go to break when time ends
            }
        }
    }
    
    func pauseTimer() {
        timerPaused.toggle()
        if timerPaused {
            timer?.invalidate()
        } else {
            startTimer() // Resume timer
        }
    }
    
    func endPomodoro() {
        timer?.invalidate()       // Stop the timer
        timeRemaining = 1500      // Reset time to 25 minutes
        timerActive = false       // Deactivate the timer
        navigateToBreak = false   // Ensure we're not navigating to the Break view
        navigateBackToContent = true // Trigger navigation back to ContentView
    }
}


#Preview {
    PomodoroTimerView(navigateBackToContent: .constant(false))
}

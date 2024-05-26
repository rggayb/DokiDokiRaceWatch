//
//  RaceView.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 21/05/24.
//

import SwiftUI

import SwiftUI

struct RaceView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var progressPlayer: Double = 0.0
    @State private var progressComputer: Double = 0.0
    @State private var heartRateComputer: Double = 0.0
    @State private var winCondition = 600.0
    @State private var computerSpeed: Double = 0.0
    
    @State private var countdown: Int = 3
    @State private var isCountingDown: Bool = true
    @State private var overlayOpacity: Double = 0.6
    
    var body: some View {
        ZStack {
            // Background image
            Image("race field black")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all) // Ensure the image covers the whole screen
            
            VStack {
                
                ZStack(alignment: .leading) {
                    // Transparent LinearProgressView
                    ProgressView(value: progressComputer)
                        .progressViewStyle(LinearProgressViewStyle(tint: .clear))
                        .frame(height: 20)
                        .background(Color.clear)
                        .overlay(
                            GeometryReader { geometry in
                                Image("car yellow") // Ganti dengan gambar objek balapan
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)
                                    .offset(x: CGFloat(progressComputer) / winCondition * (geometry.size.width - 70))
                            }
                        )
                }
                .padding(.top, 30)
                .offset(y: -35)
                Spacer()
                
                ZStack(alignment: .leading) {
                    // Transparent LinearProgressView
                    ProgressView(value: progressPlayer)
                        .progressViewStyle(LinearProgressViewStyle(tint: .clear))
                        .frame(height: 20)
                        .background(Color.clear)
                        .overlay(
                            GeometryReader { geometry in
                                Image("car green") // Ganti dengan gambar objek balapan
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)
                                    .padding(.top, 10)
                                    .offset(x: CGFloat(progressPlayer) / winCondition * (geometry.size.width - 70))
                            }
                        )
                }
                .padding(.top, 0)
                .offset(y: -25)
                Spacer()
                
                Text("COM speed: \(heartRateComputer.formatted(.number.precision(.fractionLength(0)))) bpm")
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 5)
                
                Text("Your speed: \(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0)))) bpm")
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 5)
                    .offset(y: -10)
            }
            
            if isCountingDown {
                Color.black.opacity(overlayOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                Text(countdown > 0 ? "\(countdown)" : "START")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .transition(.scale)
                    .onAppear {
                        startCountdown()
                    }
            }
            
        }
        .onAppear{
            resetRace()
            AudioManager.shared.playAudio(named: "Countdown")
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: workoutManager.heartRate) { newHeartRate in
                updateProgress(for: newHeartRate)
                WKInterfaceDevice.current().play(.success)
                
                switch Router.shared.selectedLevel {
                case "easy":
                    computerSpeed = Double.random(in: 70...90)
                case "medium":
                    computerSpeed = Double.random(in: 80...100)
                case "hard":
                    computerSpeed = Double.random(in: 100...120)
                default:
                    break
                }
                
                withAnimation(.linear(duration: 1)) {
                    progressComputer += computerSpeed
                }
                heartRateComputer = computerSpeed

        }
        
        
    }
    
    private func resetRace() {
        progressPlayer = 0.0
        progressComputer = 0.0
        heartRateComputer = 0.0
        computerSpeed = 0.0
        countdown = 3
        isCountingDown = true
        overlayOpacity = 0.6
    }
    
    private func updateProgress(for heartRate: Double) {
        if progressPlayer < winCondition {
            withAnimation(.linear(duration: 1)) {
                progressPlayer += heartRate
            }
            
            if progressPlayer > winCondition {
                withAnimation(.linear(duration: 1)) {
                    progressPlayer += 1
                    Router.shared.path.append(.feedbackWin)
                }
            }
            
            if progressComputer > winCondition {
                withAnimation(.linear(duration: 1)) {
                    progressComputer += 1
                    Router.shared.path.append(.feedbackLost)
                }
            }
        }
    }
    
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                withAnimation {
                    countdown -= 1
                }
            } else {
                withAnimation {
                    overlayOpacity = 0
                }
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isCountingDown = false
                    AudioManager.shared.playAudio(named: "Crowd Cheering")
                    AudioManager.shared.playAudio(named: "GO GO GO", fileType: "wav", loop: true)
                }
            }
        }
    }
}

#Preview {
    RaceView()
        .environmentObject(WorkoutManager())
}




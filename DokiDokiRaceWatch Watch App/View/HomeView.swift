//
//  HomeView.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 21/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @StateObject private var navPath = Router.shared
    @State private var skyOffset: CGFloat = 0
    @State private var textOffset: CGFloat = 70
    
    // Array untuk menyimpan nama file audio
    let audioFiles = ["Home Song", "DokiDokiRace"]
    
    var body: some View {
        NavigationStack (path: $navPath.path){
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<3) { _ in
                                    Image("cloud group")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 100)
                                        .padding(.top, 20)
                                        .offset(x: self.skyOffset)
                                }
                            }
                        }
                        .onAppear {
                            withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                                self.skyOffset -= WKInterfaceDevice.current().screenBounds.width
                            }
                        }
                        
                        Image("doki doki race")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160, height: 30)
                            .padding(.top, 20)
                            .offset(y: -self.textOffset)
                            .onAppear {
                                withAnimation(Animation.linear(duration: 3)) {
                                    self.textOffset = 0
                                }
                            }
                    }
                    
                    Button{
                        Router.shared.path.append(.levelSelect)
                    } label: {
                        Image("play")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .buttonStyle(.borderless)
                    .offset(y: -25)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
            .toolbar(.hidden)
            .onAppear {
                workoutManager.requestAuthorization()
                AudioManager.shared.playAudio(named: audioFiles[0], loop: true)
                AudioManager.shared.playAudio(named: audioFiles[1])
            }.navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .race:
                    RaceView()
                case .levelSelect:
                    LevelSelectView()
                case .feedbackWin:
                    FeedbackRaceViewWin()
                case .feedbackLost:
                    FeedbackRaceViewLost()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(WorkoutManager())
}

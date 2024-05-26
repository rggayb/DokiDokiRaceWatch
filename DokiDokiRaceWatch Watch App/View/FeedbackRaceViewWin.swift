//
//  FeedbackRaceView.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 22/05/24.
//

import SwiftUI

struct FeedbackRaceViewWin: View {
    let audioFiles = ["Success", "You Win", "Crowd Clap"]

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("emoji happy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 70, alignment: .center)
                    .padding(.top, 20)
                
                
                    
                Image("text you win")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 40, alignment: .center)
                    .padding(.bottom, 5)
                
                HStack{
                    HomeButton()
                }
                
            }.ignoresSafeArea()
            
            
        }.onAppear{
            AudioManager.shared.stopAllAudio() // Stop all previous audio
            AudioManager.shared.playAudio(named: audioFiles[0])
            AudioManager.shared.playAudio(named: audioFiles[1])
            AudioManager.shared.playAudio(named: audioFiles[2])
            
            WKInterfaceDevice.current().play(.notification)
        }
    }
}

#Preview {
    FeedbackRaceViewWin()
}

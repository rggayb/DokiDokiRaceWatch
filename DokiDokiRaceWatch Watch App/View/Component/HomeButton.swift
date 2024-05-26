//
//  HomeButton.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 23/05/24.
//

import SwiftUI

struct HomeButton: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.98))
                .frame(width: 50)
                        
            Button(action: {
                workoutManager.endWorkout()
                Router.shared.path.removeAll()
            }, label: {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27)
                    .foregroundColor(.white)
            })
            .padding()
            .background(Color(red: 0.94, green: 0.45, blue: 0.98))
            .clipShape(Circle())
            .buttonStyle(.borderless)
        }
    }
    
}

#Preview {
    HomeButton()
}

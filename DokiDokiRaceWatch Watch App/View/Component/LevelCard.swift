//
//  LevelCard.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 23/05/24.
//
//
//  LevelCard.swift
//  Grow Watch App
//
//  Created by Alfadli Maulana Siddik on 27/04/24.
//

import SwiftUI

struct LevelCard: View {
    var level: String
    
    var levelBackground: Color
    var chevronBackground: Color
    
    var levelIcon: String {
        if level == "easy" {
            return "level easy"
        } else if level == "medium" {
            return "level medium"
        } else {
            return "level hard"
        }
    }
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        Button {
            workoutManager.selectedWorkout = .running
            Router.shared.path.append(.race)
            Router.shared.selectedLevel = level
        } label: {
            HStack {
                Image(levelIcon)
                    .font(.system(size: 36))
                    .foregroundColor(Color(red: 0.95, green: 0.88, blue: 0.82))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16))
                    .padding()
                    .background(chevronBackground)
                    .clipShape(Circle())
                    .foregroundColor(Color(red: 0.95, green: 0.88, blue: 0.82))
                
            }
            .padding(
                EdgeInsets(
                    top: 20,
                    leading: 8,
                    bottom: 20,
                    trailing: 8
                )
            )
            .cornerRadius(16.0)
        }
        .listItemTint(levelBackground)
        .buttonStyle(.borderless)
    }
}

#Preview {
    LevelCard(level: "easy", levelBackground: Color(red: 0.44, green: 0.69, blue: 0.52), chevronBackground: Color(red: 0.62, green: 0.75, blue: 0.62))
}

//
//  DokiDokiRaceWatchApp.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 21/05/24.
//

import SwiftUI

@main
struct DokiDokiRaceWatch_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(workoutManager)
        }
    }
}

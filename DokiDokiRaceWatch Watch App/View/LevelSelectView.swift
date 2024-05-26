//
//  LevelSelectView.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 23/05/24.
//

import SwiftUI

struct LevelSelectView: View {
    @State var level: String = "easy"
    @State private var showInstructionsSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    LevelCard(level: "easy", levelBackground: Color(red: 0.54, green: 0.73, blue: 0.58), chevronBackground: Color(red: 0.62, green: 0.75, blue: 0.62))
                    LevelCard(level: "medium", levelBackground: Color(red: 0.77, green: 0.73, blue: 0.50), chevronBackground: Color(red: 0.81, green: 0.78, blue: 0.55))
                    LevelCard(level: "hard", levelBackground: Color(red: 0.79, green: 0.49, blue: 0.50), chevronBackground: Color(red: 0.84, green: 0.55, blue: 0.55))
                }
            }
            .navigationTitle("Level Select")
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .onAppear {
                showInstructionsSheet = true
            }
            .sheet(isPresented: $showInstructionsSheet) {
                InstructionSheet()
            }
        }
    }
}

struct InstructionSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Shout “GO! GO! GO!” to increase your heart rate and speed up your car!")
                    .font(.headline)
                    .padding()
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("How To Play")
        }
        
    }
}

struct Trigger: Identifiable {
    var id: String
}

#Preview {
    LevelSelectView()
}



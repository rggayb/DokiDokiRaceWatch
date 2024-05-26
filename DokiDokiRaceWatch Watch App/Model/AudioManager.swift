//
//  AudioManager.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 24/05/24.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    static let shared = AudioManager() // Singleton instance
    private var audioPlayers: [AVAudioPlayer] = []
    
    private init() {} // Private initializer to enforce singleton
    
    func playAudio(named audioName: String, fileType: String = "mp3", loop: Bool = false) {
        guard let audioPath = Bundle.main.path(forResource: audioName, ofType: fileType) else {
            print("Audio file \(audioName).\(fileType) not found")
            return
        }
        let url = URL(fileURLWithPath: audioPath)
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = loop ? -1 : 0
            audioPlayer.play()
            audioPlayers.append(audioPlayer)
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopAllAudio() {
        for player in audioPlayers {
            player.stop()
        }
        audioPlayers.removeAll()
    }
}

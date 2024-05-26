//
//  Router.swift
//  DokiDokiRaceWatch Watch App
//
//  Created by Rangga Yudhistira Brata on 22/05/24.
//

import SwiftUI

class Router: ObservableObject {
    var selectedLevel: String = "easy"
    
    @Published var path: [Destination] = []
    
    enum Destination: String, Hashable {
        case race, levelSelect, feedbackWin, feedbackLost
    }
    
    static let shared: Router = Router()
}

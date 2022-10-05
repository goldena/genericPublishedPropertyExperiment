//
//  ExperimentApp.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import SwiftUI

@main struct ExperimentApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModelProvider: ViewModelProvider())
        }
    }
    
}

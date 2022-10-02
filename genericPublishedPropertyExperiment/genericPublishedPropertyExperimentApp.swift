//
//  genericPublishedPropertyExperimentApp.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import SwiftUI

@main struct genericPublishedPropertyExperimentApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: TimerViewModel.getViewModel())
        }
    }
    
}

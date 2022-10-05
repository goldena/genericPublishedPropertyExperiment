//
//  ViewModelProvider.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 3.10.22.
//

import Foundation

@MainActor final class ViewModelProvider {
    
    private var timerService = TimerService()
    private var logService = LogService()
    
    func timerViewModel() -> TimerViewModel {
        .init(services: [timerService, logService])
    }
    
}

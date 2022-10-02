//
//  IntViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class IntViewModel: ViewModel<Int?> {
        
    private let timerService = TimerService(initialPublishedValue: nil)
    
    init() {
        super.init(initialPublishedValue: nil)
        
        self.relay(of: timerService.valuePublisher)
        
        timerService.setTimer(seconds: 30)
        timerService.start()
    }
    
}

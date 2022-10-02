//
//  IntViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class TimerViewModel: ViewModel {

    @Published private(set) var timerValue: Int?

    private let timerService: TimerService
    
    init(timerService: TimerService) {
        self.timerService = timerService
        
        super.init()
                
        timerService.setTimer(seconds: 30)
        timerService.start()
    }
    
}

extension TimerViewModel {
    
    static func getViewModel() -> TimerViewModel {
        let timerService = TimerService(initialPublishedValue: nil)
        let timerViewModel = TimerViewModel(timerService: timerService)
        
        timerViewModel.relay(
            publisher: timerService.valuePublisher
        ) { [weak timerViewModel] timerValue in
            timerViewModel?.timerValue = timerValue
        }

        return timerViewModel
    }
    
}

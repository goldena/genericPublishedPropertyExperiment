//
//  IntViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class IntViewModel: ViewModel {
    
    @Published var value: Int?
    
    private let timerService = TimerService()
    
    override init() {
        super.init()
        
        self.subscribe(to: timerService.valuePublisher) { [weak self] int in
            self?.publish(int)
        }
        
        timerService.setTimer(seconds: 30)
        timerService.start()
    }
    
}

extension IntViewModel: ValuePublisher {
        
    var valuePublisher: Published<Int?>.Publisher {
        $value
    }
        
}

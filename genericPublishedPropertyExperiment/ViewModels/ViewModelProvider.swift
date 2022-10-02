//
//  ViewModelProvider.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 3.10.22.
//

import Foundation

@MainActor final class ViewModelProvider {
    
    //    private var timerService: TimerService?
    //    private var logService: LogService?
    
    func timerViewModel() -> TimerViewModel {
        let logService = LogService(initialPublishedValue: nil)
        let timerService = TimerService(initialPublishedValue: nil)
        
        let viewModel = TimerViewModel(
            services: [
                logService,
                timerService
            ]
        )
        
        // MARK: - LogService
                
        viewModel.onReceive(
            from: logService.valuePublisher
        ) { [weak viewModel] message in
            viewModel?.message = message
        }
        
        // MARK: - TimerService
                        
        viewModel.onReceive(
            from: timerService.valuePublisher
        ) { [weak viewModel] timerValue in
            viewModel?.timerValue = timerValue
        }
        
        return viewModel
    }
    
    
}

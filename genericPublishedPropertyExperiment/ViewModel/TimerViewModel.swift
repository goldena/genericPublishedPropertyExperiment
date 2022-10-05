//
//  IntViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class TimerViewModel: ViewModel {

    @Published var seconds: Int?
    @Published var message: String?

    override func handle(data: AppData?) {
        guard let data else {
            return
        }
        
        switch data {
        case .timer(let timerData):
            switch timerData {
            case .value(let seconds):
                self.seconds = seconds
            }
            
        case .log(let logData):
            switch logData {
            case .message(let message):
                self.message = message
            }
        }
    }
    
}

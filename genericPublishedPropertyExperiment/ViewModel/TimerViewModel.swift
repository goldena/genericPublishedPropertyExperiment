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
        
    override func handle(action: AppAction?) {
        guard let action else {
            return
        }
        
        if case .timer(.value(let seconds)) = action {
            self.seconds = seconds
        }
        
        if case .log(.message(let message)) = action {
            self.message = message
        }
    }
    
}

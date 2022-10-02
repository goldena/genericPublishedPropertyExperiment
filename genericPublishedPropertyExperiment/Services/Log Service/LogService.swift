//
//  LogService.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

final class LogService: Service<String?> {
        
    // MARK: - Reset Service

    override func onDeinit() {
        super.onDeinit()
    }

    // MARK: - handle
    
    override func handle(action: AppAction) {
        guard case .log(let logAction) = action else {
            print("\(self) cannot handle \(action)")
            return
        }        
        
        switch logAction {
        case .message(let message):
            publish(value: message)
        }
    }
    
}

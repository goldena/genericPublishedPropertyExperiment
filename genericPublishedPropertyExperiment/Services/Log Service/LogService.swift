//
//  LogService.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

final class LogService: Service {
        
    // MARK: - AppActionHandler protocol
    
    override func handle(action: AppAction?) {
        guard let action else {
            return
        }
        
        guard case .log(let logAction) = action else {
            print("\(self) cannot handle \(action)")
            return
        }        
        
        switch logAction {
        case .message(let message):
            publish(action: .log(.message(message)))
        }
    }
    
}

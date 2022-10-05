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
        
        switch action {
        case .log(let logData):
            switch logData {
            case .message(let string):
                publish(data: .log(.message(string)))
            }
            
        default:
            return
        }
    }
    
}

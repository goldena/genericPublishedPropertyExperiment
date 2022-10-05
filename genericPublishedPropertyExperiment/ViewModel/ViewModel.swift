//
//  ViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation
import Combine

class ViewModel: ReactiveObject {

    // MARK: - Properties
    
    private var services: [Service] = []

    // MARK: - Init
    
    init(
        services: [Service] = []
    ) {
        self.services = services
        
        super.init(shouldReceiveValuesOn: .main)
        
        services.forEach { service in
            service.handleOnReceive(from: $action)
            
            self.handleOnReceive(from: service.$action)
        }
    }

    // MARK: - DeinitableObject protocol
    
    override func onDeinit() {
        services.forEach {
            $0.onReset()
        }
        
        super.onDeinit()
    }
    
}

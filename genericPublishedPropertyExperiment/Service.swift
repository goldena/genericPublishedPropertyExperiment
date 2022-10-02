//
//  Service.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation
import Combine

@MainActor class Service<T: Sendable>: ObservableObject {
     
    @Published private(set) var value: T
    
    private let initialPublishedValue: T
    
    init(initialPublishedValue: T) {
        self.initialPublishedValue = initialPublishedValue
        self.value = initialPublishedValue
    }
        
    func resetService() {
        publish(initialPublishedValue)
    }

    func publish(_ value: T) {
        self.value = value
    }
    
    #if DEBUG
    deinit {
        print("\(self) deinitialized")
    }
    #endif

}

extension Service: ValuePublisher {

    var valuePublisher: Published<T>.Publisher {
        $value
    }
    
}

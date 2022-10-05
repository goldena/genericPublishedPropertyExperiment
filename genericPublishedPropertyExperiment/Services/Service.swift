//
//  Service.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

class Service: ReactiveObject, Resettable {

    // MARK: - Init
    
    init() {
        super.init(shouldReceiveValuesOn: .main)
    }

    // MARK: - Resettable protocol
    
    func onReset() {
        print("--> onReset was not overridden in \(self)")
    }

}

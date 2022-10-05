//
//  Service.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

class Service: ReactiveObject {

    init() {
        super.init(shouldReceiveValuesOn: .main)
    }

}

extension Service: Resettable {
    
    func onReset() {
        print("--> onReset was not overridden in \(self)")
    }
    
}

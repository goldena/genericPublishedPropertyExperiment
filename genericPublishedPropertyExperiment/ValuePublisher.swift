//
//  ValuePublisher.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

protocol ValuePublisher: AnyObject {
    
    associatedtype T: Sendable
    
    var value: T? { get set }
    var valuePublisher: Published<T?>.Publisher { get }
    
    func publish(_ value: T?)
    
}

extension ValuePublisher {
        
    func publish(_ value: T?) {
        self.value = value
    }
    
}

//
//  ValuePublisher.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

protocol ValuePublisher: AnyObject {
    
    associatedtype T: Sendable
    
    var value: T { get }
    var valuePublisher: Published<T>.Publisher { get }

}

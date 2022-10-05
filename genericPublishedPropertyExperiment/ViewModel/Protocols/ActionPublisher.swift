//
//  ActionPublisher.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

protocol ActionPublisher: AnyObject {

    var action: AppAction? { get }

    func publish(action: AppAction?)
    
}

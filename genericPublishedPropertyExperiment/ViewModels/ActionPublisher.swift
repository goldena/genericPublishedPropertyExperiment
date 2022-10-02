//
//  ActionPublisher.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation

protocol ActionPublisher: ViewModel {

    var action: AppAction? { get }
    var actionPublisher: Published<AppAction?>.Publisher { get }

    func publish(action: AppAction)
    
}

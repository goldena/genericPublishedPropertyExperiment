//
//  ActionHandler.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 5.10.22.
//

import Foundation

protocol ActionHandler: AnyObject {
    
    func subscribeToActions(
        from publisher: Published<AppAction?>.Publisher
    )
    
    func handle(action: AppAction?)
    
}

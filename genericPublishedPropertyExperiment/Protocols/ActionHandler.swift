//
//  ActionHandler.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 5.10.22.
//

protocol ActionHandler: AnyObject {
    
    func handle(action: AppAction?)
    
}

//
//  DataHandler.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 6.10.22.
//

import Foundation

protocol DataHandler: AnyObject {
    
    func subscribeToData(
        from publisher: Published<AppData?>.Publisher
    )
    
    func handle(data: AppData?)
    
}

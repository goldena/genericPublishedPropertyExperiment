//
//  DataPublisher.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 6.10.22.
//

protocol DataPublisher: AnyObject {

    var data: AppData? { get }

    func publish(data: AppData?)
    
}

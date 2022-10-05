//
//  Service.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation
import Combine

class Service: ObservableObject, ActionHandler, Resettable {

    // MARK: - DataPublisher protocol
    
    @Published private(set) var data: AppData?
    
    // MARK: - Properties
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Functions
    
    func subscribeToActions(
        from publisher: Published<AppAction?>.Publisher
    ) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    print("Received completion from \(publisher) with \(error)")
                },
                receiveValue: { [weak self] appAction in
                    guard let self else {
                        return
                    }
                    
                    print("\(self) received new", String(describing: appAction))
                    self.handle(action: appAction)
                }
            )
            .store(in: &subscriptions)
    }

    // MARK: - ActionHandler protocol
    
    func handle(action: AppAction?) {
        print("--> handle(action) is not overridden in \(self)")
    }
    
    // MARK: - Resettable protocol
    
    func onReset() {
        print("--> onReset() was not overridden in \(self)")
    }
    
}

// MARK: - DataPublisher protocol

extension Service: DataPublisher {
    
    func publish(data: AppData?) {
        self.data = data
    }
    
}

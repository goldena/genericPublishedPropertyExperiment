//
//  ReactiveObject.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 4.10.22.
//

import Foundation
import Combine

class ReactiveObject: ObservableObject, Deinitable, ActionHandler {
    
    // MARK: - AppActionPublisher protocol
    
    @Published private(set) var action: AppAction?
    
    // MARK: - Properties
    
    private var subscriptions: Set<AnyCancellable> = []

    private let dispatchQueue: DispatchQueue

    // MARK: - Init
    
    init(
        shouldReceiveValuesOn dispatchQueue: DispatchQueue
    ) {
        self.dispatchQueue = dispatchQueue
    }
    
    func handleOnReceive(
        from publisher: Published<AppAction?>.Publisher
    ) {
        publisher
            .receive(on: dispatchQueue)
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
        
    // MARK: - DeinitableObject protocol
    
    func onDeinit() {
        print("--> onDeinit is not overridden in \(self)")
    }

    deinit {
        // onDeinit()
        
        #if DEBUG
        print("--> \(self) is deinitialized")
        #endif
    }
    
}

// MARK: - ActionPublisher protocol
              
extension ReactiveObject: ActionPublisher {
    
    func publish(action: AppAction?) {
        self.action = action
    }
    
}

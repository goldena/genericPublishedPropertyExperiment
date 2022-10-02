//
//  Service.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import Foundation
import Combine

#warning("try to create protocol")

protocol ActionHandler: AnyObject {
    
    var subscriptions: Set<AnyCancellable> { get }
    
    func onReceive(
        from publisher: Published<AppAction?>.Publisher,
        action: @escaping (AppAction?) -> Void
    )
    
    func handle(action: AppAction)
    
}

protocol Resettable {
    
    func onDeinit()
    
}

typealias GenericService = ActionHandler & Resettable

@MainActor class Service<T: Sendable>: ObservableObject, GenericService {

    @Published private(set) var value: T

    private let initialPublishedValue: T

    private(set) var subscriptions: Set<AnyCancellable> = []
    
    func onReceive(
        from publisher: Published<AppAction?>.Publisher,
        action: @escaping (AppAction?) -> Void
    ) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    print("Received completion from \(publisher) with \(error)")
                },
                receiveValue: { [weak self] publishedValue in
                    guard let self else {
                        return
                    }

                    print("\(self) received new value \(publishedValue)")
                    action(publishedValue)
                }
            )
            .store(in: &subscriptions)
    }
    
    init(initialPublishedValue: T) {
        self.initialPublishedValue = initialPublishedValue
        
        #warning("cannot call publish from here")
        self.value = initialPublishedValue
    }

    func onDeinit() {
        print("On deinit")
//        publish(value: initialPublishedValue)
    }

    func handle(action: AppAction) {
        print("handle was not overridden in \(self)")
    }
    
    deinit {
        #warning("missing in Swift, would probably be fixed soon")
        // resetService()
            
        #if DEBUG
        print("\(self) deinitialized")
        #endif
    }

}

extension Service: ValuePublisher {

    var valuePublisher: Published<T>.Publisher {
        $value
    }
    
    func publish(value: T) {
        self.value = value
    }
    
}

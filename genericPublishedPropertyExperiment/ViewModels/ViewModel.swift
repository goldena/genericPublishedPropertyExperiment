//
//  ViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation
import Combine

@MainActor class ViewModel: ObservableObject {

    @Published private(set) var action: AppAction?

    private var services: [GenericService] = []
    
    private var subscriptions: Set<AnyCancellable> = []

    init(
        services: [GenericService] = []
    ) {
        self.services = services
        
        services.forEach { service in
            service.onReceive(
                from: self.actionPublisher
            ) { [weak service] action in
                if let action {
                    service?.handle(action: action)
                }
            }
        }
    }
    
    func onReceive<T: Sendable>(
        from publisher: Published<T>.Publisher,
        action: @escaping (T) -> Void
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
        
    deinit {
        services.forEach {
            $0.onDeinit()
        }
        
        #if DEBUG
        print("\(self) deinitialized")
        #endif
    }

}

extension ViewModel: ActionPublisher {
    
    var actionPublisher: Published<AppAction?>.Publisher {
        $action
    }
    
    func publish(action: AppAction) {
        self.action = action
    }
    
}

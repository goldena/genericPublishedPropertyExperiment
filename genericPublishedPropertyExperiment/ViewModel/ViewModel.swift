//
//  ViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation
import Combine

class ViewModel: ObservableObject, Deinitable, DataHandler {

    // MARK: - ActionPublisher protocol

    @Published private(set) var action: AppAction?
    
    // MARK: - Properties
    
    private var subscriptions: Set<AnyCancellable> = []
    private var services: [Service] = []

    // MARK: - Init
    
    init(
        services: [Service] = []
    ) {
        self.services = services
        
        subscribeServices()
    }

    func subscribeToData(
        from publisher: Published<AppData?>.Publisher
    ) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    print("Received completion from \(publisher) with \(error)")
                },
                receiveValue: { [weak self] appData in
                    guard let self else {
                        return
                    }
                    
                    print("\(self) received new", String(describing: appData))
                    self.handle(data: appData)
                }
            )
            .store(in: &subscriptions)
    }

    private func subscribeServices() {
        services.forEach { service in
            service.subscribeToActions(from: $action)
            
            self.subscribeToData(from: service.$data)
        }
    }
    
    // MARK: - DataHandler protocol
    
    func handle(data: AppData?) {
        print("--> handle(data) not overridden in \(self)")
    }
    
    // MARK: - DeinitableObject protocol
    
    func onDeinit() {
        services.forEach {
            $0.onReset()
        }
    }

    deinit {
        onDeinit()
        
        #if DEBUG
        print("--> \(self) is deinitialized")
        #endif
    }
    
}

// MARK: - ActionPublisher protocol
              
extension ViewModel: ActionPublisher {
    
    func publish(action: AppAction?) {
        self.action = action
    }
    
}

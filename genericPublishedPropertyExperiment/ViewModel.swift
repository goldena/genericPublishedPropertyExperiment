//
//  ViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation
import Combine

@MainActor class ViewModel<T: Sendable>: ObservableObject {
     
    @Published private(set) var value: T
    
    private var subscriptions: Set<AnyCancellable> = []

    init(initialValue: T) {
        self.value = initialValue
    }
    
    func relay(
        of publisher: Published<T>.Publisher
    ) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in
                    print("Received completion from \(publisher) with \(error)")
                },

                receiveValue: { [weak self] publishedValue in
                    guard let self = self else {
                        return
                    }

                    print("\(self) received new value \(publishedValue)")
                    self.publish(publishedValue)
                }
            )
            .store(in: &subscriptions)
    }
    
    func publish(_ value: T) {
        self.value = value
    }

    #if DEBUG
    deinit {
        print("\(self) deinitialized")
    }
    #endif

}

extension ViewModel: ValuePublisher {

    var valuePublisher: Published<T>.Publisher {
        $value
    }
    
}

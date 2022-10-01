//
//  ViewModel.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation
import Combine

@MainActor class ViewModel: ObservableObject {
 
    private var subscriptions: Set<AnyCancellable> = []

    func subscribe<T>(
        to publisher: Published<T>.Publisher,
        _ action: @escaping (T) -> Void
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
                    action(publishedValue)
                }
            )
            .store(in: &subscriptions)
    }
    
    #if DEBUG
    deinit {
        print("\(self) deinitialized")
    }
    #endif

}

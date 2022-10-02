//
//  TimerService.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class TimerService: ViewModel<Int?> {
        
    // MARK: - Properties

    private(set) var totalSeconds: Int?

    private var timer: Timer?

    // MARK: - Reset Service

    func resetService() {
        totalSeconds = nil
        publish(nil)
    }

}

// MARK: - TimerService protocol

extension TimerService {

    func setTimer(seconds: Int) {
        assert(seconds > 0, "Trying to set timer on zero or negative value")

        totalSeconds = seconds
        publish(seconds)
    }

    func start() {
        guard timer == nil else {
            print("Timer already started")
            return
        }

        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self else {
                    print("No self in Timer.scheduleTimer() of TimerService")
                    return
                }

                if let value = self.value {
                    if value > 0 {
                        self.publish(value - 1)
                    } else {
                        self.stop()
                    }
                }

                self.publish(self.value)
            }
        )
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        guard let totalSeconds else {
            print("Timer is not set to be reset")
            return
        }

        setTimer(seconds: totalSeconds)
    }

}

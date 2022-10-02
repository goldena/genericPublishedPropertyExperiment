//
//  TimerService.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class TimerService: Service<Int?> {
        
    // MARK: - Properties

    private var timer: Timer?

    // MARK: - Reset Service

    override func onDeinit() {
        stop()
        
        super.onDeinit()
    }

    override func handle(action: AppAction) {        
        guard case .timer(let timerAction) = action else {
            print("\(self) cannot handle \(action)")
            return
        }
        
        switch timerAction {
        case .set(let seconds):
            set(seconds: seconds)
            
        case .start:
            start()
            
        case .stop:
            stop()
        }
    }
    
}

// MARK: - TimerService protocol

extension TimerService {

    private func set(seconds: Int) {
        assert(seconds > 0, "Trying to set timer on zero or negative value")

        publish(value: seconds)
    }

    private func start() {
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
                        self.publish(value: value - 1)
                    } else {
                        self.stop()
                    }
                }
            }
        )
    }

    private func stop() {
        timer?.invalidate()
        timer = nil
    }

}

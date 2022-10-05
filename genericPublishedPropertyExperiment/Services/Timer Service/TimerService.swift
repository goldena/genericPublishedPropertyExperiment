//
//  TimerService.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import Foundation

final class TimerService: Service {
    
    // MARK: - Properties
    
    private var timer: Timer?
    
    private var seconds = 0
    
    // MARK: - Deinitable Protocol
    
    override func onDeinit() {
        stop()
        
        super.onDeinit()
    }
    
    // MARK: - AppActionHandler protocol
    
    override func handle(action: AppAction?) {
        guard case .timer(let timerAction) = action else {
            return
        }
        
        switch timerAction {
        case .set(let seconds):
            set(seconds: seconds)
            
        case .start:
            start()
            
        case .stop:
            stop()
            
        default:
            return
        }
    }
    
    // MARK: - Private functions
    
    private func set(seconds: Int) {
        assert(seconds > 0, "Trying to set timer on zero or negative value")
        
        self.seconds = seconds
    }
    
    private func start() {
        guard timer == nil else {
            print("Timer already started")
            return
        }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            guard let self else {
                print("No self in Timer.scheduleTimer() of TimerService")
                return
            }
            
            if self.seconds > 0 {
                self.seconds -= 1
                self.publish(action: .timer(.value(seconds: self.seconds)))
            } else {
                self.stop()
            }
        }
    }
    
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
    
}

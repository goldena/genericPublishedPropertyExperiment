//
//  TimerView.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 2.10.22.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    @Binding var anotherScreen: Bool
    
    var body: some View {
        VStack {
            Button("Go to another screen") {
                anotherScreen.toggle()
            }
                        
            Spacer()
            
            if let timerValue = viewModel.timerValue {
                Text("Timer = \(timerValue)")
            } else {
                Text("Timer = nil")
            }
            
            Spacer()
            
            Group {
                Button("Log") {
                    viewModel.publish(action: .log(
                        .message(UUID().uuidString))
                    )
                }
                
                Spacer()
                
                if let message = viewModel.message {
                    Text("Log value: \(message)")
                }
            }
            
            Spacer()
            
            Button("Reset Timer") {
                viewModel.publish(
                    action: .timer(.set(seconds: 30))
                )
                viewModel.publish(
                    action: .timer(.start)
                )
            }
        }
        .font(.title)
        .padding()

        .onAppear {
            viewModel.publish(
                action: .timer(.set(seconds: 30))
            )
            viewModel.publish(
                action: .timer(.start)
            )
        }
    }
    
}

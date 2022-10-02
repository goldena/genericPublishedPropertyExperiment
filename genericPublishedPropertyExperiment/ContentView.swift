//
//  ContentView.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import SwiftUI

struct ContentView: View {
             
    let viewModelProvider: ViewModelProvider
    @State private var anotherScreen = false
    
    var body: some View {
        if anotherScreen {
            VStack {
                Button("Go to another screen") {
                    anotherScreen.toggle()
                }
                
                Spacer()
                
                Text("Another screen")
                
                Spacer()
            }
            .font(.title)
        } else {
            TimerView(
                viewModel: viewModelProvider.timerViewModel(),
                anotherScreen: $anotherScreen
            )
        }
    }
    
}

//
//  ContentView.swift
//  genericPublishedPropertyExperiment
//
//  Created by Denis Goloborodko on 1.10.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: IntViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Generic @Published property experiment")
            
            Spacer()
            
            if let int = viewModel.value {
                Text("int = \(int)")
            } else {
                Text("int = nil")
            }
            
            Spacer()
        }
        .font(.title)
        .padding()
    }
    
}

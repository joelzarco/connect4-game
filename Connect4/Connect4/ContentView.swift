//
//  ContentView.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 07/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    
    @AppStorage("playerColor") var playerColor = Color.pink
    @AppStorage("computerColor") var computerColor = Color.yellow
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

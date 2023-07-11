//
//  SettingsView.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 11/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    
    @AppStorage("playerColor") var playerColor = Color.pink
    @AppStorage("computerColor") var computerColor = Color.yellow
    
    var body: some View {
        List{
            Section(header: Text("Piece Color")) {
                ColorPicker("Player color", selection: $playerColor)
                ColorPicker("Computer color", selection: $computerColor)
            }
            
            Section(header: Text("Current score")) {
                Text("Total wins: \(win)")
                Text("Total losses: \(lose)")
                Text("Ties: \(tie)")
            }
            
            Section(header: Text("Reset score")) {
                Button{
                    win = 0
                    lose = 0
                    tie = 0
                }label: {
                    HStack{
                        Text("Clear score data")
                        Spacer()
                        Image(systemName: "arrow.triangle.2.ciclepath.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.primary)
                            .frame(width: 25, height: 25)
                    }
                }
            } // last sec
            
        } //lst
        .listStyle(.grouped)
        .navigationTitle("Settings")
    }
}

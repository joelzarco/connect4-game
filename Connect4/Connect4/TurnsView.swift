//
//  TurnsView.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 13/07/23.
//

import SwiftUI

struct TurnsView: View {
    let turn : Turn
    
    var body: some View {
        HStack{// lower turn label
            Spacer()
            switch turn {
            case .user:
                Text("Your turn")
                    .font(.title.bold())
            case .computer:
                Text("Computer's turn")
                    .font(.title.bold())
            case .userWin:
                Text("You won!")
                    .font(.title.bold())
            case .computerWin:
                Text("You lost!!!")
                    .font(.title.bold())
            case .tie:
                Text("No one wins :(")
                    .font(.title.bold())
            }
            Spacer()
        } // hs
        .padding(8)
        .background(.blue.opacity(0.7))
        .cornerRadius(15)
        .padding(.bottom, 10)
    }
}



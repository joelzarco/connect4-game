//
//  HeaderView.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 13/07/23.
//

import SwiftUI

struct HeaderView: View {
    let playerColor : Color
    let compColor : Color
    let circleWidth : CGFloat
    let userNumber : Int
    let computerNumber : Int
    var body: some View {
        HStack{
            CirclePiece(circleColor: playerColor, circleWidth: circleWidth)
            VStack{
                HStack{
                    Text("You")
                    Spacer()
                    Text("Computer")
                }
                .font(.title3.bold())
                HStack{
                    Text("\(userNumber)")
                    Spacer()
                    Text("vs")
                    Spacer()
                    Text("\(computerNumber)")
                } // hs numbers
            } // innVS
            CirclePiece(circleColor: compColor, circleWidth: circleWidth)
        } // outHS
    }
}



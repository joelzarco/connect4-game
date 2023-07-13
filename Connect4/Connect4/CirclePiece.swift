//
//  CirclePiece.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 12/07/23.
//

import SwiftUI

struct CirclePiece: View {
    let circleColor : Color
    let circleWidth : CGFloat
    var body: some View {
        Circle()
            .frame(width: circleWidth, height: circleWidth)
            .foregroundColor(circleColor)
    }
}

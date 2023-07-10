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
    
    @State private var userPieces = 21
    @State private var computerPieces = 21
    @State private var hole = Array(repeating: Hole.blank, count: 42)
    @State private var turn = Turn.user
    @State private var connectIndex : [Int] = []
    @State private var selectTab = 0
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                VStack{
                    HStack{
                        Circle()
                            .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                            .foregroundColor(playerColor)
                        VStack{
                            HStack{
                                Text("You")
                                Spacer()
                                Text("Computer")
                            }
                            .font(.title3.bold())
                            HStack{
                                Text("\(userPieces)")
                                Spacer()
                                Text("vs")
                                Text("\(computerPieces)")
                            } //hs
                        } // vs
                        Circle()
                            .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                            .foregroundColor(computerColor)
                    } //hs whole upper user vs computer ui block
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                        ForEach(0..<42){ index in
                            switch hole[index]{
                            case .blank:
                                Circle()
                                    .frame(width: geometry.size.width / 9, height: geometry.size.height / 9)
                                    .foregroundColor(.black.opacity(0.5))
                                    .onTapGesture {
                                        print("circle \(index) tapped")
                                        if(turn == .user){
                                            // playerTurn()
                                        }
                                    }
                            case .user:
                                if(connectIndex.contains(index)){
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(playerColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.height / 9)
                                } else{
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.height / 9)
                                        .foregroundColor(playerColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index % 7] == .blank){
                                                // playerTurn(index : index)
                                            }
                                        }
                                } // else
                                
                            case .computer:
                                if(connectIndex.contains(index)){
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(computerColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.height / 9)
                                    
                                }else{
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.height / 9)
                                        .foregroundColor(computerColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index % 7] == .blank){
                                                // playerTurn()
                                            }
                                        }
                                }
                            } //sw
                        } // for
                    } //lzV
                    .padding()
                    .background(.blue.opacity(0.6))
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                    
                    HStack{
                        // lower buttons here
                    }
                } //vs
            } // nav
            
        } // geo
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

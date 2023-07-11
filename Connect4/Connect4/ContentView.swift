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
                                    .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                    .foregroundColor(.black.opacity(0.5))
                                    .onTapGesture {
                                        print("circle \(index) tapped")
                                        if(turn == .user){
                                             playerTurn(index: index)
                                        }
                                    }
                            case .user:
                                if(connectIndex.contains(index)){
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(playerColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                } else{
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                        .foregroundColor(playerColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index % 7] == .blank){
                                                 playerTurn(index: index)
                                            }
                                        }
                                } // else
                                
                            case .computer:
                                if(connectIndex.contains(index)){
                                    Circle()
                                        .strokeBorder(Color.white, lineWidth: 4)
                                        .background(Circle().fill(computerColor))
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                    
                                }else{
                                    Circle()
                                        .frame(width: geometry.size.width / 9, height: geometry.size.width / 9)
                                        .foregroundColor(computerColor)
                                        .onTapGesture {
                                            if(turn == .user && hole[index % 7] == .blank){
                                                 playerTurn(index: index)
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
                    
                    HStack{// lower turn buttons here
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
                    
                    if(turn != .user && turn != .computer){ // no one's turn then start next round
                        HStack{
                            Spacer()
                            Button{
                                userPieces = 21
                                computerPieces = 21
                                hole = Array(repeating: .blank, count: 42)
                                turn = .user
                                connectIndex = []
                            }label: {
                                Text("Start next round")
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                        } // inHS
                        .padding(8)
                        .background(.blue.opacity(0.7))
                        .cornerRadius(15)
                    } // restarting if block
                    Spacer()
                } //vs
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Connect 4")
                            .bold()
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            Button{
                                if(turn != .computer){
                                    userPieces = 21
                                    computerPieces = 21
                                    hole = Array(repeating: .blank, count: 42)
                                    turn = .user
                                    connectIndex = []
                                }
                            }label: {
                                Image(systemName: "arrow.counterclockwise.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(8)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                            NavigationLink{
                                Text("Settings view")
                            }label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(8)
                                    .background(.quaternary)
                                    .cornerRadius(15)
                            }
                        } // toolB hs
                    } // restart
                } // toolB
            } // nav
            
        } // geo
    } // someV
    
    func playerTurn(index: Int) {
            turn = .computer
            userPieces -= 1
            var topIdx = index % 7
            var blankNum = 0
            while (hole[topIdx] == .blank && topIdx+7 <= 41 && hole[topIdx+7] == .blank) {
                blankNum += 1
                topIdx += 7
            }
            var idx = index % 7
            for i in 0...blankNum {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                    if(idx>6) {
                        self.hole[idx-7] = .blank
                    }
                    self.hole[idx] = .user
                    idx += 7
                    if(i == blankNum) {
                        checkFinish()
                        if(turn == .computer) {
                            computerTurn()
                        }
                    }
                }
            }
        } // playerTurn()
///
    func computerTurn() {
            computerPieces -= 1
            // check "|"
            for row in 0...2 {
                for col in 0...6 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col+7] != .blank
                        && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                        && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
            // check "\" and drop at left
            for row in 0...2 {
                for col in 0...3 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col+7] != .blank
                        && self.hole[7*row+col+8] != .blank
                        && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                        && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
            // check "\" and drop at right
            for row in 0...2 {
                for col in 0...3 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+8]
                        && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                        && self.hole[7*row+col+24] == .blank) {
                        if(7*row+col+31<=41 && self.hole[7*row+col+31] != .blank) {
                            computerDrop(col: col+24, row: row+3)
                            return
                        } else if(7*row+col+31>41) {
                            computerDrop(col: col+24, row: row+3)
                            return
                        }
                    }
                }
            }
            // check "/" and drop at left
            for row in 0...2 {
                for col in 3...6 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+6]
                        && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                        && self.hole[7*row+col+18] == .blank) {
                        if(7*row+col+25<=41 && self.hole[7*row+col+25] != .blank) {
                            computerDrop(col: col+18, row: row+3)
                            return
                        } else if(7*row+col+25>41) {
                            computerDrop(col: col+18, row: row+3)
                            return
                        }
                    }
                }
            }
            // check "/" and drop at right
            for row in 0...2 {
                for col in 3...6 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col+6] != .blank
                        && self.hole[7*row+col+7] != .blank
                        && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                        && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                        computerDrop(col: col, row: row)
                        return
                    }
                }
            }
            // check "-" and drop at left to win
            for row in 0...5 {
                for col in 0...3 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col+1] == .computer
                        && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                        && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                        if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                            computerDrop(col: col, row: row)
                            return
                        } else if(7*row+col+7>41) {
                            computerDrop(col: col, row: row)
                            return
                        }
                    }
                }
            }
            // check "-" and drop at right to win
            for row in 0...5 {
                for col in 3...6 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col-1] == .computer
                        && self.hole[7*row+col-1] == self.hole[7*row+col-2]
                        && self.hole[7*row+col-2] == self.hole[7*row+col-3]) {
                        if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                            computerDrop(col: col, row: row)
                            return
                        } else if(7*row+col+7>41) {
                            computerDrop(col: col, row: row)
                            return
                        }
                    }
                }
            }
            // check "-" and drop at left to prevent user win
            for row in 0...5 {
                for col in 0...4 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col+1] == .user
                        && self.hole[7*row+col+1] == self.hole[7*row+col+2]) {
                        if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                            computerDrop(col: col, row: row)
                            return
                        } else if(7*row+col+7>41) {
                            computerDrop(col: col, row: row)
                            return
                        }
                    }
                }
            }
            // check "-" and drop at right to prevent user win
            for row in 0...5 {
                for col in 2...6 {
                    if (self.hole[7*row+col] == .blank
                        && self.hole[7*row+col-1] == .user
                        && self.hole[7*row+col-1] == self.hole[7*row+col-2]) {
                        if(7*row+col+7<=41 && self.hole[7*row+col+7] != .blank) {
                            computerDrop(col: col, row: row)
                            return
                        } else if(7*row+col+7>41) {
                            computerDrop(col: col, row: row)
                            return
                        }
                    }
                }
            }
            
            var col = Int.random(in: 0...6)
            while (self.hole[col] != .blank) {
                col = Int.random(in: 0...6)
            }
            var blankNum = 0
            while (hole[col] == .blank && col+7 <= 41 && hole[col+7] == .blank) {
                blankNum += 1
                col += 7
            }
            computerDrop(col: col, row: blankNum)
        }
    /// computerTurn()
    
    // ->
    func computerDrop(col: Int, row: Int) {
            var idx = col % 7
            for i in 0...row {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12*Double(i)) {
                    if(idx>6) {
                        self.hole[idx-7] = .blank
                    }
                    self.hole[idx] = .computer
                    idx += 7
                    if(i == row) {
                        checkFinish()
                        if(turn == .computer) {
                            if(computerPieces == 0) {
                                turn = .tie
                                tie += 1
                            } else {
                                turn = .user
                            }
                        }
                    }
                }
            }
        }
    // <- ComputerDrop()
    
    // -> checkFinish()
    func checkFinish() {
            // check "|"
            for row in 0...2 {
                for col in 0...6 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+7]
                        && self.hole[7*row+col+7] == self.hole[7*row+col+14]
                        && self.hole[7*row+col+14] == self.hole[7*row+col+21]) {
                        connectIndex.append(7*row+col)
                        connectIndex.append(7*row+col+7)
                        connectIndex.append(7*row+col+14)
                        connectIndex.append(7*row+col+21)
                        if(self.hole[7*row+col] == .user) {
                            turn = .userWin
                            win += 1
                        } else {
                            turn = .computerWin
                            lose += 1
                        }
                        return
                    }
                }
            }
            // check "-"
            for row in 0...5 {
                for col in 0...3 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+1]
                        && self.hole[7*row+col+1] == self.hole[7*row+col+2]
                        && self.hole[7*row+col+2] == self.hole[7*row+col+3]) {
                        connectIndex.append(7*row+col)
                        connectIndex.append(7*row+col+1)
                        connectIndex.append(7*row+col+2)
                        connectIndex.append(7*row+col+3)
                        if(self.hole[7*row+col] == .user) {
                            turn = .userWin
                            win += 1
                        } else {
                            turn = .computerWin
                            lose += 1
                        }
                        return
                    }
                }
            }
            // check "\"
            for row in 0...2 {
                for col in 0...3 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+8]
                        && self.hole[7*row+col+8] == self.hole[7*row+col+16]
                        && self.hole[7*row+col+16] == self.hole[7*row+col+24]) {
                        connectIndex.append(7*row+col)
                        connectIndex.append(7*row+col+8)
                        connectIndex.append(7*row+col+16)
                        connectIndex.append(7*row+col+24)
                        if(self.hole[7*row+col] == .user) {
                            turn = .userWin
                            win += 1
                        } else {
                            turn = .computerWin
                            lose += 1
                        }
                        return
                    }
                }
            }
            // check "/"
            for row in 0...2 {
                for col in 3...6 {
                    if (self.hole[7*row+col] != .blank
                        && self.hole[7*row+col] == self.hole[7*row+col+6]
                        && self.hole[7*row+col+6] == self.hole[7*row+col+12]
                        && self.hole[7*row+col+12] == self.hole[7*row+col+18]) {
                        connectIndex.append(7*row+col)
                        connectIndex.append(7*row+col+6)
                        connectIndex.append(7*row+col+12)
                        connectIndex.append(7*row+col+18)
                        if(self.hole[7*row+col] == .user) {
                            turn = .userWin
                            win += 1
                        } else {
                            turn = .computerWin
                            lose += 1
                        }
                        return
                    }
                }
            }
        }
    // <_
    
    
}

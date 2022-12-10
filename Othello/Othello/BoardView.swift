//
//  BoardView.swift
//  Othello
//
//  Created by tsune on 2022/12/10.
//

import SwiftUI
import UIKit

struct BoardView: View {
    //盤面を作る
    @State private var isTapped1: Bool = false
    @State private var isTapped2: Bool = false
    
    var body: some View {
        Rectangle()
          .frame(width: 100, height: 100)
          .foregroundColor(isTapped1 ? .green : .gray )
          .onTapGesture {
              self.isTapped1.toggle()
          }
        Circle()
          .frame(width: 50, height: 50)
          .foregroundColor(isTapped2 ? .white : .black )
          .onTapGesture {
            self.isTapped2.toggle()
          }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}

//-----------------------ここから別のコード----------------------------
//
//class Calc: ObservableObject {
//    @Published var size: Int = 0
//}
//
////碁盤を表示するためのクラス
//class GoBoard {
//    var board = [[String]]()
//    
//    init(calc: Calc) {
//        for _ in 0..<calc.size {
//            var row = [String]()
//            for _ in 0..<calc.size {
//                row.append(".")
//            }
//            board.append(row)
//        }
//    }
//
//    func printBoard(calc: Calc) {
//        for row in 0..<calc.size {
//            var rowString = ""
//            for col in 0..<calc.size {
//                rowString += board[row][col] + " "
//            }
//            print(rowString)
//        }
//    }
//}
//
////プレイヤーが碁盤上に駒を置くためのクラス
//class Player {
//    let mark: String
//    let name: String
//
//    init(mark: String, name: String) {
//        self.mark = mark
//        self.name = name
//    }
//
//    func makeMove(board: GoBoard) {
//        var row: Int
//        var col: Int
//        repeat {
//            print("\(name)さんの番です。どこに置きますか？")
//            print("行を入力してください: ", terminator: "")
//            row = Int(readLine()!)!
//            print("列を入力してください: ", terminator: "")
//            col = Int(readLine()!)!
//        } while board.board[row][col] != "."
//
//        board.board[row][col] = mark
//    }
//}
//
////ゲーム全体を管理するクラス
//class GoGame {
//    var board: GoBoard
//    var player1: Player
//    var player2: Player
//    
//    init(player1: Player, player2: Player, calc: Calc) {
//        self.board = GoBoard(calc.size: 9)
//        self.player1 = player1
//        self.player2 = player2
//    }
//    
//    func playGame() {
//        while true {
//            player1.makeMove(board: board)
//            board.printBoard()
//            if checkForWin() {
//                break
//            }
//            player2.makeMove(board: board)
//            board.printBoard()
//            if checkForWin() {
//                break
//            }
//        }
//    }
//    
//    //勝利条件を定義するためのcheckForWin
//    func checkForWin(calc: Calc) -> Bool {
//        // 碁盤全体を調べる
//        for row in 0..<calc.size {
//            for col in 0..<size {
//                if board.board[row][col] != "." {
//                    // 周りの8マスを調べる
//                    for i in -1..<2 {
//                        for j in -1..<2 {
//                            if i == 0 && j == 0 {
//                                continue
//                            }
//                            // 周り8マスを検索し、5つ並んでいれば勝利
//                            let x = row + i
//                            let y = col + j
//                            if x >= 0 && x < size && y >= 0 && y < size {
//                                if board.board[x][y] == board.board[row][col] {
//                                    let x2 = x + i
//                                    let y2 = y + j
//                                    if x2 >= 0 && x2 < size && y2 >= 0 && y2 < size {
//                                        if board.board[x2][y2] == board.board[row][col] {
//                                            let x3 = x2 + i
//                                            let y3 = y2 + j
//                                            if x3 >= 0 && x3 < size && y3 >= 0 && y3 < size {
//                                                if board.board[x3][y3] == board.board[row][col] {
//                                                    let x4 = x3 + i
//                                                    let y4 = y3 + j
//                                                    if x4 >= 0 && x4 < size && y4 >= 0 && y4 < size {
//                                                        if board.board[x4][y4] == board.board[row][col] {
//                                                            print("\(board.board[row][col])の勝ちです！")
//                                                            return true
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    //ゲームを実行する
//    func gamePlay(calc: Calc) {
//        let player1 = Player(mark: "B", name: "Black")
//        let player2 = Player(mark: "W", name: "White")
//        let game = GoGame(player1: player1, player2: player2)
//        game.playGame()
//    }
//}
//

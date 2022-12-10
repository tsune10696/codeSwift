//
//  OthelloFunc.swift
//  Othello
//
//  Created by tsune on 2022/12/09.
//

import Foundation
import UIKit
import SwiftUI

//必要な変数や配列を定義
let BOARD_SIZE = 8
//BOARD_SIZE=8の場合boardは[0][0]から[7][7]まで作成されている
var board = [[Int]](repeating: [Int](repeating: 0, count: BOARD_SIZE), count: BOARD_SIZE)

//盤面を初期化するための関数を定義
func initBoard() {
    for i in 0..<BOARD_SIZE {
        for j in 0..<BOARD_SIZE {
            if (i == 3 && j == 3) || (i == 4 && j == 4) {
                board[i][j] = 1   //黒が1
            } else if (i == 3 && j == 4) || (i == 4 && j == 3) {
                board[i][j] = -1  //白が-1
            }
        }
    }
}

//石を置くための関数を定義
//colorパラメーターは、置かれる石の色を表す(黒が1、白が-1)
//xとyパラメーターはその石を置く場所の座標を表す
//戻り値として、石が正常に置かれたかどうかを示すBool値が返される
func putStone(color: Int, x: Int, y: Int) -> Bool {
    if board[x][y] != 0 {
        return false
    }
    var canPut = false
    for dx in -1...1 {
        for dy in -1...1 {
            if dx == 0 && dy == 0 {
                continue
            }
            var nx = x + dx
            var ny = y + dy
            if nx < 0 || nx >= BOARD_SIZE || ny < 0 || ny >= BOARD_SIZE {
                continue
            }
            if board[nx][ny] == -color {
                nx += dx
                ny += dy
                while nx >= 0 && nx < BOARD_SIZE && ny >= 0 && ny < BOARD_SIZE && board[nx][ny] == -color {
                    nx += dx
                    ny += dy
                }
                if nx >= 0 && nx < BOARD_SIZE && ny >= 0 && ny < BOARD_SIZE && board[nx][ny] == color {
                    canPut = true
                    while (nx - dx != x) || (ny - dy != y) {
                        nx -= dx
                        ny -= dy
                        board[nx][ny] = color
                    }
                }
            }
        }
    }
    if canPut {
        board[x][y] = color
    }
    return canPut
}

//盤面上の石の数を数えるための関数を定義
func countStones() -> (Int, Int) {
    var black = 0
    var white = 0
    for i in 0..<BOARD_SIZE {
        for j in 0..<BOARD_SIZE {
            if board[i][j] == 1 {
                black += 1
            } else if board[i][j] == -1 {
                white += 1
            }
        }
    }
    return (black, white)
}

//石を置くことができるかどうかを判定するための関数を定義
func canPutStones(color: Int) -> Bool {
    for i in 0..<BOARD_SIZE {
        for j in 0..<BOARD_SIZE {
            if putStone(color: color, x: i, y: j){
                return true
            }
        }
    }
    return false
}

//ゲームの終了判定を行うための関数を定義
func isGameEnd() -> Bool {
    for i in 0..<BOARD_SIZE {
        for j in 0..<BOARD_SIZE {
            if board[i][j] == 0 {
                return false
            }
        }
    }
    return true
}

////ゲームをプレイするための関数を定義
//func playGame() {
//    var currentPlayer = 1
//
//    initBoard()
//
//    while !isGameEnd() {
////        printBoard()
//
//        var canPut = false
//        while !canPut {
//            print("Player \(currentPlayer), please enter x and y:")
//            let x = readLine()
//            let y = readLine()
//            canPut = putStone(color: currentPlayer, x: x, y: y)
//            if !canPut {
//                print("Invalid move, please try again.")
//            }
//        }
//
//        currentPlayer *= -1
//    }
//
////    printBoard()
//    print("Game end.")
//}


//
//  ContentView.swift
//  Othello
//
//  Created by tsune on 2022/12/09.
//
//ここにはViewに関するもの以外記載しないこと

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack{
            Button(action: {
                initBoard()
            }){
                Text("初期化してください")
            }
            .padding(10)
            Button(action: {
                let ps = putStone(color: 1, x: 1, y: 1)
                print(ps)
            }){
                Text("石を置く準備をしてください")
            }
            .padding(10)
            Button(action: {
                let cps = canPutStones(color: 1)
                print(cps)
            }){
                Text("石が置けるか確認")
            }
            .padding(10)
            Button(action: {
                let cs = countStones()
                print(cs)
            }){
                Text("石を数えます")
            }
            .padding(10)
            Button(action: {
                let ige = isGameEnd()
                print(ige)
            }){
                Text("ゲームの終了判定")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  OperatorButtons.swift
//  ArchiDentaku
//
//  Created by tsune on 2022/11/21.
//

import SwiftUI
import Darwin
import Foundation
import UIKit

//四則演算部分の定義をする
struct OperatorButtons: View {
    
    @ObservedObject var calc: Calc
    
    var body: some View {
        VStack {
            //割り算
            MyButton(title: "÷", color: calc.buttonColor[0]) {
                if calc.enzanTag == true && calc.dotUse == false {
                    calc.calcProcess.removeLast()
                    calc.calcProcess += "/"
                } else if calc.dotUse == false {
                    calc.calcProcess += ".0/"
                } else {
                    calc.calcProcess += "/"
                    calc.dotUse = false
                }
                calc.buttonColor = [Color.blue, Color.white, Color.white, Color.white]
                calc.enzanTag = true
            }
            .padding(3)
            //掛け算
            MyButton(title: "×", color: calc.buttonColor[1]) {
                if calc.enzanTag == true && calc.dotUse == false {
                    calc.calcProcess.removeLast()
                    calc.calcProcess += "*"
                } else if calc.dotUse == false {
                    calc.calcProcess += ".0*"
                } else {
                    calc.calcProcess += "*"
                    calc.dotUse = false
                }
                calc.buttonColor = [Color.white, Color.blue, Color.white, Color.white]
                calc.enzanTag = true
            }
            .padding(3)
            //引き算
            MyButton(title: "ー", color: calc.buttonColor[2]) {
                if calc.enzanTag == true && calc.dotUse == false {
                    calc.calcProcess.removeLast()
                    calc.calcProcess += "-"
                } else if calc.dotUse == false {
                    calc.calcProcess += ".0-"
                } else {
                    calc.calcProcess += "-"
                    calc.dotUse = false
                }
                calc.buttonColor = [Color.white,  Color.white, Color.blue, Color.white]
                calc.enzanTag = true
            }
            .padding(3)
            //足し算
            MyButton(title: "＋", color: calc.buttonColor[3]) {
                if calc.enzanTag == true && calc.dotUse == false {
                    calc.calcProcess.removeLast()
                    calc.calcProcess += "+"
                } else if calc.dotUse == false {
                    calc.calcProcess += ".0+"
                } else {
                    calc.calcProcess += "+"
                    calc.dotUse = false
                }
                calc.buttonColor = [Color.white, Color.white, Color.white, Color.blue]
                calc.enzanTag = true
            }
            .padding(3)
            //イコール
            MyButton(title: "=") {
                //演算子連続エラー出力
                if calc.calcProcess.contains("++") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("--") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("**") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("//") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("..") {
                    calc.showAlert = true
                //演算子周りの入力間違い
                } else if calc.calcProcess.contains(".+") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains(".-") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains(".*") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("./") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("+.") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("-.") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("*.") {
                    calc.showAlert = true
                } else if calc.calcProcess.contains("/.") {
                    calc.showAlert = true
                //何も入力されてない場合は何も実行しない
                } else if calc.calcProcess == "" {
                //先頭か末尾に演算子等がある場合のエラー出力
                } else if calc.calcProcess.hasPrefix(".") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasPrefix("+") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasPrefix("-") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasPrefix("*") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasPrefix("/") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix(".") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix("+") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix("-") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix("*") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix("/") {
                    calc.showAlert = true
                } else if calc.calcProcess.hasSuffix("=") {
                    calc.showAlert = true
                //ゼロで割らない場合の実行ルート
                } else if calc.calcProcess.contains("/0") && calc.calcProcess.contains("/0.") {
                    if calc.dotUse == false {
                        calc.calcProcess += ".0"
                    }
                    let expression = NSExpression(format: calc.calcProcess)
                    calc.output = expression.expressionValue(with: nil, context: nil) as! Double
                    calc.roundOutput = (calc.output * 10000000).rounded() / 10000000
                    calc.buttonColor = [Color.white, Color.white, Color.white, Color.white]
                    calc.calcProcess += "="
                    calc.dotUse = false
                    calc.enzanTag = true
                //ゼロで割る場合のエラー出力
                } else if calc.calcProcess.contains("/0"){
                    calc.showAlert = true
                //その他の実行ルート
                } else {
                    if calc.dotUse == false {
                        calc.calcProcess += ".0"
                    }
                    let expression = NSExpression(format: calc.calcProcess)
                    calc.output = expression.expressionValue(with: nil, context: nil) as! Double
                    calc.roundOutput = (calc.output * 10000000).rounded() / 10000000
                    calc.buttonColor = [Color.white, Color.white, Color.white, Color.white]
                    calc.calcProcess += "="
                    calc.dotUse = false
                    calc.enzanTag = true
                }
            }
            .padding(3)
        }
    }
}
//四則演算以外の機能を定義する
struct OtherOperatorButtons: View {
            
    @ObservedObject var calc: Calc
            
    var body: some View {
        HStack {
            //値のクリア
            MyButton(title: "CLEAR", width: 260) {
                calc.output = 0.0
                calc.roundOutput = 0.0
                calc.buttonColor = [Color.white, Color.white, Color.white, Color.white]
                calc.calcProcess = ""
                calc.dotUse = false
                calc.enzanTag = false
            }
//            //一文字消す
//            MyButton(title: "◀︎") {
//                if calc.calcProcess == "" {
//                }
//                if calc.calcProcess.hasSuffix(".") {
//                    calc.dotUse = false
//                    print(11)
//                }
//                if calc.calcProcess.hasSuffix("+") {
//                    calc.enzanTag = false
//                }
//                if calc.calcProcess.hasSuffix("-") {
//                    calc.enzanTag = false
//                }
//                if calc.calcProcess.hasSuffix("*") {
//                    calc.enzanTag = false
//                }
//                if calc.calcProcess.hasSuffix("/") {
//                    calc.enzanTag = false
//                }
//                calc.calcProcess.removeLast()
//                calc.buttonColor = [Color.white, Color.white, Color.white, Color.white]
//            }
        }
        .padding(3)
    }
}

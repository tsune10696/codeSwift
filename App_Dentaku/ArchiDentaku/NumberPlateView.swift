//
//  NumberPlateView.swift
//  ArchiDentaku
//
//  Created by tsune on 2022/11/21.
//

import SwiftUI

//計算用のボタンを並べる
struct NumberPlateView: View {
    
    @ObservedObject var calc: Calc
    
    var body: some View {
        VStack {
            HStack {
                MyButton(title: "7", handler: {
                        calc.calcProcess += "7"
                        calc.enzanTag = false
                })
                MyButton(title: "8", handler: {
                        calc.calcProcess += "8"
                        calc.enzanTag = false
                })
                MyButton(title: "9", handler: {
                        calc.calcProcess += "9"
                        calc.enzanTag = false
                })
            }
            .padding(3)
            
            HStack {
                MyButton(title: "4", handler: {
                        calc.calcProcess += "4"
                        calc.enzanTag = false
                })
                MyButton(title: "5", handler: {
                        calc.calcProcess += "5"
                        calc.enzanTag = false
                })
                MyButton(title: "6", handler: {
                        calc.calcProcess += "6"
                        calc.enzanTag = false
                })
            }
            .padding(3)
            
            HStack {
                MyButton(title: "1", handler: {
                        calc.calcProcess += "1"
                        calc.enzanTag = false
                })
                MyButton(title: "2", handler: {
                        calc.calcProcess += "2"
                        calc.enzanTag = false
                })
                MyButton(title: "3", handler: {
                        calc.calcProcess += "3"
                        calc.enzanTag = false
                })
            }
            .padding(3)
            HStack {
                MyButton(title: "0", width: 170, handler: {
                        calc.calcProcess += "0"
                        calc.enzanTag = false
                })
                MyButton(title: ".") {
                    calc.calcProcess += "."
                    calc.buttonColor = [Color.white, Color.white, Color.white, Color.white]
                    calc.dotUse = true
                    calc.enzanTag = false
                }
            }
            .padding(3)
        }
    }
}
//RadiusButtonの設定
struct MyButton: View {
    var title: String
    var width: CGFloat?
    var color: Color?
    var handler: () -> Void
    
    var body: some View {
        Button(action: {
            self.handler()
        }) {
            Text(title)
                .frame(width: width ?? 80.0, height: 80.0)
                .background(color ?? Color.init(.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(.blue, lineWidth: 2)
                )
        }
    }
}

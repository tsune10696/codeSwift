//
//  ContentView.swift
//  ArchiDentaku
//
//  Created by tsune on 2022/11/21.
//

import SwiftUI

//数値結果の部分を定義
struct ContentView: View {
    
    @ObservedObject var calc = Calc()
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(calc.calcProcess))
                .font(.system(size: 50))
                .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: .trailing)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
            Text(String(calc.roundOutput))
                .font(.system(size: 70))
                .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: .trailing)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(.blue)
                .minimumScaleFactor(0.5)
            KeyboardView(calc: calc)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
        .background(Color.white)
        .alert(isPresented: $calc.showAlert) {
            Alert(title: Text("注意"),
                  message: Text("計算式に誤りがあります"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

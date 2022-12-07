//
//  KeyboradView.swift
//  ArchiDentaku
//
//  Created by tsune on 2022/11/21.
//

import SwiftUI

//ボタン全体の並べ方を定義
struct KeyboardView: View {
    
    @ObservedObject var calc: Calc
    
    var body: some View {
        HStack {
            VStack {
                OtherOperatorButtons(calc: calc)
                NumberPlateView(calc: calc)
                    .padding(3)
            }
            OperatorButtons(calc: calc)
        }
        .accentColor(.blue)
        .font(.title)
    }
}

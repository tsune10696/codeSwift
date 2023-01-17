//
//  ContentView.swift
//  Honyaku
//
//  Created by Ippei.T on 2022/12/25.
//
import SwiftUI
import UIKit

// タブを表示
struct ContentView: View {
    var body: some View {
        HStack {
            TranslateView()
            .padding(3)
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

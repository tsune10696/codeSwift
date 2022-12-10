//
//  ContentView.swift
//  Honyaku
//
//  Created by tsune on 2022/12/06.
//

import SwiftUI
import NCMB
import UIKit

// タブを表示
struct ContentView: View {
    var body: some View {
        HStack {
            TranslateView()
            .padding(3)
        }
        .accentColor(.black)
        
//        TabView {
//                    TranslateView()
//                        .tabItem {
//                            VStack {
//                                Image(systemName: "textformat")
//                                Text("翻訳")
//                            }
//                    }.tag(1)
//                    HistoryView()
//                        .tabItem {
//                            VStack {
//                                Image(systemName: "list.bullet")
//                                Text("履歴")
//                            }
//                    }.tag(2)
//                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

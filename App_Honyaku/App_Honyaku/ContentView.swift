//
//  ContentView.swift
//  Honyaku
//
//  Created by tunaProducts on 2022/12/22.
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

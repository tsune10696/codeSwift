//
//  DetailView.swift
//  Honyaku
//
//  Created by tsune on 2022/12/06.
//

import SwiftUI
import NCMB

// 詳細表示画面
struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    // 一覧画面からNCMBObjectを受け取る
    @State var translate: NCMBObject
    
    // 画面表示
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                Text((translate["original"] ?? "") as String)
                Spacer()
                Text((translate["translate"] ?? "") as String)
                Spacer()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let translate = NCMBObject.init(className: "Translate")
        translate["original"] = "日本語"
        translate["translate"] = "Japanese"
        return DetailView(translate: translate)
    }
}

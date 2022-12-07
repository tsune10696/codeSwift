//
//  HistoryView.swift
//  Honyaku
//
//  Created by tsune on 2022/12/06.
//

import SwiftUI
import NCMB

// NCMBから取得した結果が入るObservableObject
class Histories: ObservableObject {
    @Published var items: [NCMBObject] = []
}

// 履歴画面用
struct HistoryView: View {
    // 履歴が入る配列
    @ObservedObject var History = Histories()
    // NCBMから履歴を取得する処理
    func getHistories() {
        let query : NCMBQuery<NCMBObject> = NCMBQuery.getQuery(className: "Translate")
        // 検索処理を実行します。処理は非同期です        //
        query.findInBackground(callback: { result in
            // 取得できた場合
            if case let .success(array)  = result {
                // メインスレッドなので main.async を使います
                DispatchQueue.main.async {
                    // 結果を適用します
                    History.items = array
                }
            } else {
                print("取得に失敗しました")
            }
        })
    }
    // 画面表示
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack{
                    List {
                        ForEach(self.History.items, id: \.objectId) { translate in
                            // translateはNCMBObjectです
                            // タスク文字列をタップしたらDetailViewを呼び出します
                            NavigationLink(destination: DetailView(translate: translate)) {
                                Text((translate["original"] ?? "") as String)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("履歴", displayMode: .inline)
            .onAppear {
                // 画面表示したら履歴を取得する処理を呼び出す
                getHistories()
            }
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

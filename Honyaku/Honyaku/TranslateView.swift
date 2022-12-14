//
//  TranslateView.swift
//  Honyaku
//
//  Created by tsune on 2022/12/06.
//

import SwiftUI
import Alamofire
import NCMB
import UIKit

// DeepL APIのレスポンス用構造体
struct DeepLResult: Codable {
    let translations: [Translation]
    struct Translation: Codable {
        var detected_source_language: String
        var text: String
    }
}

// 翻訳用ビュー
struct TranslateView: View {
    // 入力文章のテキスト
    @State private var originalText = ""
    // 翻訳結果のテキスト
    @State private var translatedText = ""
    // 保存完了した際のアラート制御用
    @State private var uploaded = false
    // JSONデコード用
    let decoder: JSONDecoder = JSONDecoder()
    
    // 翻訳実行
    func translation() {
        // APIKey.plistに保存したDeepLの認証キーを取得
        let authKey = KeyManager().getValue(key: "DeepLAuthKey") as! String
        // APIリクエストするパラメータを作成
        let parameters: [String: String] = [
            "text": originalText,
            "target_lang": "JA",
            "auth_key": authKey
        ]
        // ヘッダーを作成
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // DeepL APIを実行
        AF.request("https://api-free.deepl.com/v2/translate", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable(of: DeepLResult.self) { response in
            // リクエスト成功か判定
            if case .success = response.result {
                do {
                    // 結果をデコード
                    let result = try decoder.decode(DeepLResult.self, from: response.data!)
                    // 結果のテキストを取得&画面に反映
                    translatedText =  result.translations[0].text
//                    // 結果をNCMBに保存する処理を呼び出し
//                    saveResult()
                } catch {
                    debugPrint("デコード失敗")
                }
            } else {
                debugPrint("APIリクエストエラー")
            }
        }
    }
    
//    // 翻訳結果をNCMBに保存する処理
//    func saveResult() {
//        let translate = NCMBObject(className: "Translate")
//        translate["original"] = originalText
//        translate["translate"] = translatedText
//        translate.saveInBackground(callback: { result in
//            uploaded = true
//        })
//    }

    // 画面表示
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack{
                    VStack(spacing:20){
                        // 入力欄
                        Text("""
                             ・翻訳後の言語は日本語のみとなります
                             """)
//                        Text("""
//                            ・翻訳可能な言語：
//                             Bulgarian, Czech, Danish
//                             German, Greek, English, Spanish
//                             Estonian, Finnish, French, Hungarian
//                             Indonesian, Italian, Lithuanian
//                             Latvian, Dutch, Polish, Portuguese
//                             Romanian, Russian, Slovak, Slovenian
//                             Swedish, Turkish, Ukrainian, Chinese
//                            """)
                        Text("◯ここに翻訳したい文章を入力します")
                        TextEditor(text: $originalText)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 280, maxHeight: 100)
                            .padding(.bottom)
                        // 翻訳結果があれば表示
                        if translatedText != "" {
                            Text("↓")
                            Text("◯翻訳結果")
                            Text(translatedText).padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 280, maxHeight: 100)
                        }
                        Spacer()
                        // 翻訳実行するボタン
                        Button(action: {
                            translation()
                        }, label: {
                            Text("日本語に翻訳！")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                        })
                        .padding(.bottom)
                    }
                }
            }
            .navigationBarTitle("Honyaku", displayMode: .inline)
//            // 保存完了時のアラート用
//            .alert(isPresented: $uploaded, content: {
//                Alert(
//                    title: Text("保存完了"),
//                    message: Text("翻訳結果を記録しました"),
//                    dismissButton: .default(Text("閉じる"))
//                )
//            })
                
        }
    }
}


struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        TranslateView()
    }
}

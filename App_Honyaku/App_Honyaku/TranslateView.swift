//
//  TranslateView.swift
//  Honyaku
//
//  Created by tunaProducts on 2022/12/22.
//

import SwiftUI
import Alamofire
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
                } catch {
                    debugPrint("デコード失敗")
                }
            } else {
                debugPrint("APIリクエストエラー")
            }
        }
    }
    // 画面表示
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack{
                    VStack(spacing:20){
                        Spacer()
                        // 入力欄
//                            ・翻訳可能な言語：
//                             Bulgarian, Czech, Danish
//                             German, Greek, English, Spanish
//                             Estonian, Finnish, French, Hungarian
//                             Indonesian, Italian, Lithuanian
//                             Latvian, Dutch, Polish, Portuguese
//                             Romanian, Russian, Slovak, Slovenian
//                             Swedish, Turkish, Ukrainian, Chinese
                        TextEditor(text: $originalText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 300, maxHeight: 200)
                            .shadow(color: .gray, radius: 5, x: 3, y: 3)
                            .onTapGesture {
                                self.originalText = ""
                            }
                            .onAppear(){
                                self.originalText = "ここに翻訳したい文章を入力"
                            }
                        // 翻訳結果があれば表示
                        if translatedText != "" {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 20, height: 20)
                            TextEditor(text: $translatedText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: 300, maxHeight: 200)
                                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                            HStack(spacing:20){
                                Text("翻訳結果をコピー：")
                                Button(action: {
                                    UIPasteboard.general.string = translatedText
                                }, label: {
                                    Image(systemName: "doc.on.doc.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                })
                            }
                        }
                        Spacer()
                        // 翻訳実行するボタン
                        Button(action: {
                            translation()
                        }, label: {
                            Image("honyakuButton")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1))
                        })
                        .padding(.bottom)
                    }
                }
            }
        }
    }
}


struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        TranslateView()
    }
}

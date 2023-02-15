## read me

GitHub上には、APIキーを記載するswiftファイルは保存しておりません。
各自、APIキーを取得して、以下のような、swiftファイル(APIkeys.swift)を作成願います。


```Swift
//
//  APIkeys.swift
//

import Foundation

extension Environment {
  struct APIKeys {
    static let pexels: (key: String, header: String) = ("「取得したＡＰＩキーをここに記載」", "Authorization")
  }
}
```

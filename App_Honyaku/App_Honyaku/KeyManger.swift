//
//  KeyManger.swift
//  Honyaku
//
//  Created by tsune on 2022/12/25.
//

import Foundation

// APIKey.plistの内容を返してくれるオブジェクト
struct KeyManager {

    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")

    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key]! as AnyObject
    }
}

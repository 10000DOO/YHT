//
//  RealmManager.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import RealmSwift

class RealmManager {
    let configuration: Realm.Configuration
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        var keyData = Data(count: 64)
        _ = keyData.withUnsafeMutableBytes { bytes in
            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        }

        configuration = Realm.Configuration(encryptionKey: keyData)

        do {
            realm = try Realm(configuration: configuration)
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
}

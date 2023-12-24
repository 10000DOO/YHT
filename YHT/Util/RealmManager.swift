//
//  RealmManager.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        realm = try! Realm()
    }
}

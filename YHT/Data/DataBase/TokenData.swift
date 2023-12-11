//
//  TokenData.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import Foundation
import RealmSwift

class TokenData: Object {
    
    @Persisted var tokenName: String?
    @Persisted var tokenContent: String?
}

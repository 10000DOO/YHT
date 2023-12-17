//
//  Query.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import Foundation
import RealmSwift

class Query {

    static func insertToken(accessToken: TokenData, refreshToken: TokenData) -> ErrorResponse? {
        let realm = RealmManager.shared.realm

        do {
            try realm.write {
                if let existingToken = realm.objects(TokenData.self).filter("tokenName == %@", "accessToken").first {
                    existingToken.tokenContent = accessToken.tokenContent
                } else {
                    realm.add(accessToken)
                }

                if let existingToken = realm.objects(TokenData.self).filter("tokenName == %@", "refreshToken").first {
                    existingToken.tokenContent = refreshToken.tokenContent
                } else {
                    realm.add(refreshToken)
                }
            }
            return nil
        } catch {
            return ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
        }
    }
}


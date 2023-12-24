//
//  SignInResponse.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import Foundation

struct SignInResponse: Codable {
    let status: Int
    let data: TokenInfo
}

struct TokenInfo: Codable {
    let grantType: String
    let username: String
    let accessToken: String
    let refreshToken: String
}

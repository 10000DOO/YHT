//
//  SignUpRequest.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation

struct SignUpRequest: Codable {
    let loginId: String
    let password: String
    let username: String
    let email: String
    let field: String
}

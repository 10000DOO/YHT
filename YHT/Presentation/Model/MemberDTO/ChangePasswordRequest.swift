//
//  ChangePasswordRequest.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import Foundation

struct ChangePasswordRequest: Codable {
    let password: String
    let email: String
}

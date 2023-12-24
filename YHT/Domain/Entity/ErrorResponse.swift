//
//  ErrorResponse.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let status: Int
    let error: [ErrorDetail]
}

struct ErrorDetail: Codable {
    let error: String
}

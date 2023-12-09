//
//  EmailSendResponse.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation

struct EmailSendResponse: Codable {
    var status: Int
    var data: emailInfo
}

struct emailInfo: Codable {
    var target: String
    var code: String
}

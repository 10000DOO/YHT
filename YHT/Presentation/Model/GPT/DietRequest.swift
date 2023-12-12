//
//  DietRequest.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation

struct DietRequest: Codable {
    let food: [String]
    let healthPurpose: String
    let height: Int
    let weight: Int
}

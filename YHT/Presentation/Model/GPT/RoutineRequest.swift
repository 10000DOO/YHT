//
//  RoutineRequest.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation

struct RoutineRequest: Codable {
    let healthPurpose: String
    let height: Int
    let weight: Int
    let divisions: Int
}

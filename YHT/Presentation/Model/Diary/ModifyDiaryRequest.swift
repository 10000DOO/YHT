//
//  ModifyDiaryRequest.swift
//  YHT
//
//  Created by 이건준 on 12/23/23.
//

import Foundation

struct ModifyDiaryRequest: Codable {
    let exerciseInfo: [ExerciseInfo]
    let review: String
    let exerciseDate: String
}

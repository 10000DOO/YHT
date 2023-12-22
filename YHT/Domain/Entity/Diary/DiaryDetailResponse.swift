//
//  DiaryDetailResponse.swift
//  YHT
//
//  Created by 이건준 on 12/22/23.
//

import Foundation

struct DiaryDetailResponse: Codable {
    let status: Int
    let data: DiaryData
}

struct DiaryData: Codable {
    let diaryId: Int
    let exerciseDate: String
    let review: String
    let exerciseInfo: [ExerciseInfo]
    let dateTime: DateTime
    let mediaList: [String]
}

struct ExerciseInfo: Codable, Hashable {
    let exerciseName: String
    let reps: Int?
    let exSetCount: Int?
    let cardio: Bool
    let cardioTime: Int?
    let bodyPart: String?
    var finished: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(exerciseName)
        hasher.combine(reps)
        hasher.combine(exSetCount)
        hasher.combine(cardio)
        hasher.combine(cardioTime)
        hasher.combine(bodyPart)
        hasher.combine(finished)
    }
}

struct DateTime: Codable {
    let createdAt: String
    let canceledAt: String?
    let updatedAt: String
}


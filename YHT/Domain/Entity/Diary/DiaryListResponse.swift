//
//  DiaryListResponse.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation

struct DiaryListResponse: Codable {
    let status: Int
    let data: CalendarDetails
}

struct CalendarDetails: Codable {
    let today: String
    let calenders: [ExerciseCalendar]
    let monthlyPercentage: Int
}

struct ExerciseCalendar: Codable {
    let exerciseDate: String
    let dailyPercentage: Int
    let diaryId: Int
}

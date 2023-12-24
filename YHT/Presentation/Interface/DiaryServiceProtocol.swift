//
//  DiaryServiceProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Combine

protocol DiaryServiceProtocol {
    
    func getDiaryList(date: String) -> AnyPublisher<CalendarDetails, ErrorResponse>
    
    func getDiaryDetail(date: String) -> AnyPublisher<DiaryData, ErrorResponse>
    
    func addDiary(exerciseInfos: [ExerciseInfo], review: String, exerciseDate: String) -> AnyPublisher<Bool, ErrorResponse>
    
    func modifyDiary(exerciseInfos: [ExerciseInfo], review: String, exerciseDate: String, diaryId: Int) -> AnyPublisher<Bool, ErrorResponse>
    
    func deleteDiary(diaryId: Int) -> AnyPublisher<Bool, ErrorResponse>
}

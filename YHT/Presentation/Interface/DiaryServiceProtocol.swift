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
}

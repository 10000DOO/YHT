//
//  DiaryRepositoryProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Combine

protocol DiaryRepositoryProtocol {
    func getDiaryList(date: String, accessToken: String?) -> AnyPublisher<DiaryListResponse, ErrorResponse>
    
    func getDiaryDetail(date: String, accessToken: String?) -> AnyPublisher<DiaryDetailResponse, ErrorResponse>
}

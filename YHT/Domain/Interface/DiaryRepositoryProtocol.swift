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
    
    func addDiary(modifyDiaryRequest: ModifyDiaryRequest, accessToken: String?) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func modifyDiary(modifyDiaryRequest: ModifyDiaryRequest, accessToken: String?, diaryId: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func deleteDiary(diaryId: Int, accessToken: String?) -> AnyPublisher<CommonSuccessResInt, ErrorResponse>
}

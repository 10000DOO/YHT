//
//  DiaryService.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Combine

class DiaryService: DiaryServiceProtocol {
    private let diaryRepository: DiaryRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(diaryRepository: DiaryRepositoryProtocol) {
        self.diaryRepository = diaryRepository
    }
    
    func getDiaryList(date: String) -> AnyPublisher<CalendarDetails, ErrorResponse> {
        return Future<CalendarDetails, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.diaryRepository.getDiaryList(date: date, accessToken: accessToken)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(response.data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func getDiaryDetail(date: String) -> AnyPublisher<DiaryData, ErrorResponse> {
        return Future<DiaryData, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.diaryRepository.getDiaryDetail(date: date, accessToken: accessToken)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(response.data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func addDiary(exerciseInfos: [ExerciseInfo], review: String, exerciseDate: String) -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.diaryRepository.addDiary(modifyDiaryRequest: ModifyDiaryRequest(exerciseInfo: exerciseInfos, review: review, exerciseDate: exerciseDate), accessToken: accessToken)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(true))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func modifyDiary(exerciseInfos: [ExerciseInfo], review: String, exerciseDate: String, diaryId: Int) -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.diaryRepository.modifyDiary(modifyDiaryRequest: ModifyDiaryRequest(exerciseInfo: exerciseInfos, review: review, exerciseDate: exerciseDate), accessToken: accessToken, diaryId: diaryId)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(true))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func deleteDiary(diaryId: Int) -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.diaryRepository.deleteDiary(diaryId: diaryId, accessToken: accessToken)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(true))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}

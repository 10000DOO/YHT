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
            self?.diaryRepository.getDiaryList(date: date, accessToken: RealmManager.shared.realm.objects(TokenData.self).filter("tokenName == %@", "accessToken").first?.tokenContent)
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
}

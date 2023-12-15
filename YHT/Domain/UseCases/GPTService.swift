//
//  GPTService.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Combine

class GPTService: GPTServiceProtocol {
    private let gptRepository: GPTRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(gptRepository: GPTRepositoryProtocol) {
        self.gptRepository = gptRepository
    }
    
    func recommendRoutine(healthPurpose: String, height: Int, weight: Int, divisions: Int) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.gptRepository.recommendRoutine(routineRequest: RoutineRequest(healthPurpose: healthPurpose, height: height, weight: weight, divisions: divisions))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    var data = response.data
                    data = data.replacingOccurrences(of: "1일차: ", with: "1일차:\n")
                    data = data.replacingOccurrences(of: "2일차: ", with: "\n\n2일차:\n")
                    data = data.replacingOccurrences(of: "3일차: ", with: "\n\n3일차:\n")
                    data = data.replacingOccurrences(of: "4일차: ", with: "\n\n4일차:\n")
                    data = data.replacingOccurrences(of: "5일차: ", with: "\n\n5일차:\n")
                    data = data.replacingOccurrences(of: "결과는", with: "\n\n결과는")
                    promise(.success(data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func recommendDiet(healthPurpose: String, height: Int, weight: Int, diet: [String]) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.gptRepository.recommendDiet(dietRequest: DietRequest(food: diet, healthPurpose: healthPurpose, height: height, weight: weight))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    var data = response.data
                    data = data.replacingOccurrences(of: "다.", with: "다.\n")
                    data = data.replacingOccurrences(of: "요. ", with: "요.\n")
                    data = data.replacingOccurrences(of: "결과는", with: "\n\n결과는")
                    promise(.success(data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func recommendReview(exerciseName: String, muscleName: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.gptRepository.recommendReview(reviewRequest: ReviewRequest(exerciseName: exerciseName, muscleName: muscleName))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    var data = response.data
                    data = data.replacingOccurrences(of: "정상적인 자극 부위:", with: "정상적인 자극 부위:\n")
                    data = data.replacingOccurrences(of: "잘못된 자극 부위:", with: "\n잘못된 자극 부위:")
                    data = data.replacingOccurrences(of: "잘못된 이유:", with: "\n잘못된 이유:")
                    data = data.replacingOccurrences(of: "수정 방법:", with: "\n수정 방법:")
                    data = data.replacingOccurrences(of: "결과는", with: "\n\n결과는")
                    promise(.success(data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}

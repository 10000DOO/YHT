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
    
    func changePassowrd(healthPurpose: String, height: Int, weight: Int, divisions: Int) -> AnyPublisher<String, ErrorResponse> {
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
}

//
//  RoutineViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import Foundation
import Combine

class RoutineViewModel: ObservableObject {
    
    @Published var height = 170
    @Published var weight = 60
    @Published var exercisePurpose = ""
    @Published var divisions = 3
    @Published var result = ""
    @Published var isGptSuccess = false
    var cancellables = Set<AnyCancellable>()
    private let gptService: GPTServiceProtocol
    
    init(gptService: GPTServiceProtocol) {
        self.gptService = gptService
    }
    
    func routineButtonClicked() {
        result = "답변 생성중..."
        if exercisePurpose == "근육 증가" || exercisePurpose == ""{
            exercisePurpose = "MUSCLE_GAIN"
        } else {
            exercisePurpose = "LOOSING_WEIGHT"
        }
        gptService.recommendRoutine(healthPurpose: exercisePurpose, height: height, weight: weight, divisions: divisions)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let errorMessage = error.error.first!.error
                    self?.result = errorMessage
                }
            } receiveValue: { [weak self] response in
                self?.result = response
            }.store(in: &cancellables)
    }
}

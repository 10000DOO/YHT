//
//  DietViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Combine

class DietViewModel: ObservableObject {
    
    @Published var height = 170
    @Published var weight = 60
    @Published var exercisePurpose = ""
    @Published var diet: [String] = []
    @Published var result = "답변 생성중..."
    @Published var isGptSuccess = false
    @Published var addFood = false
    @Published var food = ""
    var cancellables = Set<AnyCancellable>()
    private let gptService: GPTServiceProtocol
    
    init(gptService: GPTServiceProtocol) {
        self.gptService = gptService
    }
    
    func dietButtonClicked() {
        if exercisePurpose == "근육 증가" || exercisePurpose == ""{
            exercisePurpose = "MUSCLE_GAIN"
        } else {
            exercisePurpose = "LOOSING_WEIGHT"
        }
        gptService.recommendDiet(healthPurpose: exercisePurpose, height: height, weight: weight, diet: diet)
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

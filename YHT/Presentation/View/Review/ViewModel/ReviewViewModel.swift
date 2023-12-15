//
//  ReviewViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/15/23.
//

import Foundation
import Combine

class ReviewViewModel: ObservableObject {
    
    @Published var isAbsShow = false
    @Published var isBicepsShow = false
    @Published var isCalvesShow = false
    @Published var isChestShow = false
    @Published var isForearmsShow = false
    @Published var isQuadricepsShow = false
    @Published var isShoulderShow = false
    @Published var isBackCalvesShow = false
    @Published var isBackForearmsShow = false
    @Published var isGlutesShow = false
    @Published var isHamstringsShow = false
    @Published var isLatShow = false
    @Published var isBackShoulderShow = false
    @Published var isTrapShow = false
    @Published var isTricepsShow = false
    @Published var exerciseName = ""
    @Published var result = "답변 생성중..."
    @Published var isGptSuccess = false
    var cancellables = Set<AnyCancellable>()
    private let gptService: GPTServiceProtocol
    
    init(gptService: GPTServiceProtocol) {
        self.gptService = gptService
    }
    
    func reviewButtonClicked() {
        var muscleName = ""
        if isAbsShow {
            muscleName += "복근, "
        }
        if isBicepsShow {
            muscleName += "이두근, "
        }
        if isCalvesShow {
            muscleName += "비복근, "
        }
        if isChestShow {
            muscleName += "대흉근, "
        }
        if isForearmsShow {
            muscleName += "전완근, "
        }
        if isQuadricepsShow {
            muscleName += "대퇴사두근, "
        }
        if isShoulderShow {
            muscleName += "삼각근, "
        }
        if isBackCalvesShow {
            muscleName += "비복근, "
        }
        if isBackForearmsShow {
            muscleName += "전완근, "
        }
        if isGlutesShow {
            muscleName += "둔근, "
        }
        if isHamstringsShow {
            muscleName += "대퇴이두근, "
        }
        if isLatShow {
            muscleName += "광배근, "
        }
        if isBackShoulderShow {
            muscleName += "후면삼각근, "
        }
        if isTrapShow {
            muscleName += "승모근, "
        }
        if isTricepsShow {
            muscleName += "삼두근, "
        }
        
        muscleName = String(muscleName.dropLast())
        muscleName = String(muscleName.dropLast())
        
        gptService.recommendReview(exerciseName: exerciseName, muscleName: muscleName)
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

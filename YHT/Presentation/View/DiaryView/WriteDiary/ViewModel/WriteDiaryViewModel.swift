//
//  WriteDiaryViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/21/23.
//

import Foundation
import Combine

class WriteDiaryViewModel: ObservableObject {
    
    @Published var exerciseType = "근력 운동"
    @Published var exerciseName = ""
    @Published var exerciseReps = ""
    @Published var exerciseSetCount = ""
    @Published var exerciseReview = ""
    @Published var cardioTime = ""
    @Published var addExercise = false
    @Published var addReview = false
    @Published var exerciseInfo: [ExerciseInfo] = []
    @Published var mediaList: [String] = []
    @Published var refreshTokenExpired = false
    var cancellables = Set<AnyCancellable>()
    private let diaryService: DiaryServiceProtocol
    private let memberService: MemberServiceProtocol
    
    init(diaryService: DiaryServiceProtocol, memberService: MemberServiceProtocol) {
        self.diaryService = diaryService
        self.memberService = memberService
    }
    
    func getDiaryDetail(date: String) {
        diaryService.getDiaryDetail(date: date)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.rawValue {
                        self?.memberService.issueNewToken()
                            .sink(receiveCompletion: { completion in
                                switch completion {
                                case .failure(let error):
                                    if error.error[0].error == ErrorMessage.expiredRefreshToken.rawValue {
                                        self?.refreshTokenExpired = true
                                    } else {
                                        self?.getDiaryDetail(date: date)
                                    }
                                case .finished:
                                    break
                                }
                            }, receiveValue: { result in
                                if result {
                                    self?.getDiaryDetail(date: date)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.exerciseReview = response.review
                self?.exerciseInfo = response.exerciseInfo
                self?.mediaList = response.mediaList
            }.store(in: &cancellables)
    }
    
    func addWeightTraining() {
        if exerciseName != "" && exerciseReps != "" && exerciseSetCount != "" {
            if let exerciseReps = Int(exerciseReps), let exerciseSetCount = Int(exerciseSetCount) {
                exerciseInfo.append(ExerciseInfo(exerciseName: exerciseName, reps: exerciseReps, exSetCount: exerciseSetCount, cardio: false, cardioTime: nil, bodyPart: nil, finished: false))
            }
        }
    }
    
    func addCardio() {
        if exerciseName != "" && cardioTime != "" {
            if let cardioTime = Int(cardioTime) {
                exerciseInfo.append(ExerciseInfo(exerciseName: exerciseName, reps: nil, exSetCount: nil, cardio: true, cardioTime: cardioTime, bodyPart: nil, finished: false))
            }
        }
    }
}

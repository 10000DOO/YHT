//
//  DiaryViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Combine

class DiaryViewModel: ObservableObject {
    
    @Published var diaryList: [ExerciseCalendar] = []
    @Published var refreshTokenExpired = false
    @Published var monthlyPercentage = 0.0
    @Published var targetMonth = ""
    @Published var currentDate = Date()
    @Published var memberDeleted = false
    var cancellables = Set<AnyCancellable>()
    private let diaryService: DiaryServiceProtocol
    private let memberService: MemberServiceProtocol
    
    init(diaryService: DiaryServiceProtocol, memberService: MemberServiceProtocol) {
        self.diaryService = diaryService
        self.memberService = memberService
    }
    
    func getDiaryList(date: String) {
        diaryService.getDiaryList(date: date)
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
                                        self?.getDiaryList(date: date)
                                    }
                                case .finished:
                                    break
                                }
                            }, receiveValue: { result in
                                if result {
                                    self?.getDiaryList(date: date)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.diaryList = response.calenders
                self?.monthlyPercentage = Double(response.monthlyPercentage) / 100.0
            }.store(in: &cancellables)
    }
    
    func deleteMember() {
        memberService.deleteDiary()
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
                                        self?.deleteMember()
                                    }
                                case .finished:
                                    break
                                }
                            }, receiveValue: { result in
                                if result {
                                    self?.deleteMember()
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.memberDeleted = true
            }.store(in: &cancellables)
    }
}

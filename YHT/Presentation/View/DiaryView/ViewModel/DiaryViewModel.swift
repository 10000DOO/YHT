//
//  DiaryViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Combine

class DiaryViewModel: ObservableObject {
    
    @Published var diaryList: CalendarDetails?
    @Published var refreshTokenExpired = false
    var cancellables = Set<AnyCancellable>()
    private let diaryService: DiaryServiceProtocol
    private let memberService: MemberServiceProtocol
    
    init(diaryService: DiaryServiceProtocol, memberService: MemberServiceProtocol) {
        self.diaryService = diaryService
        self.memberService = memberService
    }
    
    func getDiaryList() {
        diaryService.getDiaryList(date: "2023-09")
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
                                        self?.getDiaryList()
                                    }
                                case .finished:
                                    break
                                }
                            }, receiveValue: { result in
                                if result {
                                    self?.getDiaryList()
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                print(response)
                self?.diaryList = response
            }.store(in: &cancellables)
    }
}

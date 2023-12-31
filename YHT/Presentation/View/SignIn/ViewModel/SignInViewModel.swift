//
//  SignInViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var signInError = ""
    @Published var signInSuccess = false
    private let memberService: MemberServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(memberService: MemberServiceProtocol) {
        self.memberService = memberService
    }
    
    func signInButtonClicked() {
        if !id.isEmpty && !password.isEmpty {
            memberService.signIn(id: id, password: password)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        let errorMessage = error.error.first!.error
                        self?.signInError = errorMessage
                    }
                } receiveValue: { [weak self] response in
                    UserDefaults.standard.setValue(response, forKey: "username")
                    self?.signInError = ""
                    self?.signInSuccess = true
                }.store(in: &cancellables)
        }
    }
}


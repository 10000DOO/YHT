//
//  FindIdViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import Foundation
import Combine

class FindIdViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var codeText: String = ""
    @Published var emailError: String = ""
    @Published var codeError: String = ""
    @Published var signUpSuccess: Bool = false
    private let emailService: EmailServiceProtocol
    private let memberService: MemberServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(emailService: EmailServiceProtocol, memberService: MemberServiceProtocol) {
        self.emailService = emailService
        self.memberService = memberService
    }
    
    func isValidEmail() {
        if emailService.checkEmailValidation(email: emailText) {
            emailError = ErrorMessage.availableEmail.rawValue
        } else {
            emailError = ErrorMessage.wrongEmailPattern.rawValue
        }
    }
    
    func emailButtonClick() {
        emailService.sendEmail(email: emailText)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.emailError = error.error.first!.error
                }
            } receiveValue: { response in
            }.store(in: &cancellables)
    }
}

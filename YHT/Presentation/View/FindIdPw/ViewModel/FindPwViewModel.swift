//
//  FindPwViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import Foundation
import Combine

class FindPwViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var codeText: String = ""
    @Published var emailError: String = ""
    @Published var codeError: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    @Published var passwordError: String = ""
    @Published var passwordCheckError: String = ""
    @Published var signUpSuccess: Bool = false
    @Published var isCodeRight: Bool = false
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
    
    func isValidPassword() {
        if memberService.checkPasswordValidation(password: passwordText) {
            passwordError = ErrorMessage.availablePassword.rawValue
        } else {
            passwordError = ErrorMessage.wrongPasswordPattern.rawValue
        }
    }
    
    func isValidPasswordCheck() {
        if passwordText == confirmPasswordText && !passwordText.isEmpty {
            passwordCheckError = ErrorMessage.passwordMatching.rawValue
        } else {
            passwordCheckError = ErrorMessage.passwordNotMatching.rawValue
        }
    }
}

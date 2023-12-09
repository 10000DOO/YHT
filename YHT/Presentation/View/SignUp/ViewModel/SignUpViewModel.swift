//
//  SignUpViewModel.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var codeText: String = ""
    @Published var usernameText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    @Published var idText: String = ""
    @Published var emailError: String = ""
    @Published var codeError: String = ""
    @Published var idError: String = ""
    @Published var passwordError: String = ""
    @Published var passwordCheckError: String = ""
    @Published var usernameError: String = ""
    @Published var isCodeTextFieldVisible: Bool = false
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
    
    func isValidId() {
        if memberService.checkIdValidation(id: idText) {
            idError = ErrorMessage.availableLoginId.rawValue
        } else {
            idError = ErrorMessage.wrongLoginIdPattern.rawValue
        }
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
    
    func isValidNickname() {
        if usernameText.count > 0 && usernameText.count <= 20 {
            usernameError = ErrorMessage.availableNickName.rawValue
        } else {
            usernameError = ErrorMessage.wrongNickNamePattern.rawValue
        }
    }
    
    func signUpButtonClicked() {
        if !emailText.isEmpty && !codeText.isEmpty && !idText.isEmpty && !passwordText.isEmpty && !usernameText.isEmpty && emailError == ErrorMessage.availableEmail.rawValue && idError == ErrorMessage.availableLoginId.rawValue && passwordError == ErrorMessage.availablePassword.rawValue && passwordCheckError == ErrorMessage.passwordMatching.rawValue && usernameError == ErrorMessage.availableNickName.rawValue {
            memberService.signUp(email: emailText, emailCode: codeText, id: idText, password: passwordText, username: usernameText)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        let errorMessage = error.error.first!.error
                        if errorMessage.contains("이메일") {
                            self?.emailError = errorMessage
                        }
                        if errorMessage.contains("아이디") {
                            self?.idError = errorMessage
                        }
                        if errorMessage.contains("이름") {
                            self?.usernameError = errorMessage
                        }
                        if errorMessage.contains("코드") {
                            self?.codeError = errorMessage
                        }
                    }
                } receiveValue: { [weak self] response in
                    self?.signUpSuccess = true
                }.store(in: &cancellables)
        }
    }
}

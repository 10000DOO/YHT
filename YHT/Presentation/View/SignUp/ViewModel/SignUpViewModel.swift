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
    @Published var idError: String = ""
    @Published var passwordError: String = ""
    @Published var passwordCheckError: String = ""
    @Published var isCodeTextFieldVisible: Bool = false
    private let emailService: EmailServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(emailService: EmailServiceProtocol) {
        self.emailService = emailService
    }
    
    func isValidEmail() -> Bool {
        return emailService.checkEmailValidation(email: emailText)
    }
    
    func emailButtonClick() {
        emailService.sendEmail(email: emailText)
    }
}

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
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: emailText)
    }
}

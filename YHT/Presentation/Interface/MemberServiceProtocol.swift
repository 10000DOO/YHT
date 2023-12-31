//
//  MemberServiceProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation
import Combine

protocol MemberServiceProtocol {
    
    func checkIdValidation(id: String) -> Bool
    
    func checkPasswordValidation(password: String) -> Bool
    
    func signUp(email: String, emailCode: String, id: String, password: String, username: String) -> AnyPublisher<String, ErrorResponse>
    
    func signIn(id: String, password: String) -> AnyPublisher<String, ErrorResponse>
    
    func findId(code: String) -> AnyPublisher<String, ErrorResponse>
    
    func changePassowrd(password: String, email: String) -> AnyPublisher<Bool, ErrorResponse>
    
    func issueNewToken() -> AnyPublisher<Bool, ErrorResponse>
    
    func deleteDiary() -> AnyPublisher<Bool, ErrorResponse>
}

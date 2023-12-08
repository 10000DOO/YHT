//
//  EmailServiceProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Combine

protocol EmailServiceProtocol {
    
    func sendEmail(email: String) -> AnyPublisher<Never, ErrorResponse>
    
    func checkEmailValidation(email: String) -> Bool
    
//    func checkCode(emailCode: String) -> AnyPublisher<String, ErrorResponse>
}

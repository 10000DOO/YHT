//
//  EmailRepositoryProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Combine

protocol EmailRepositoryProtocol {
    
    func sendEmail(email: String) -> AnyPublisher<EmailSendResponse, ErrorResponse>
    
//    func checkEmailCode(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
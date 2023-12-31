//
//  EmailRepositoryProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Combine

protocol EmailRepositoryProtocol {
    
    func sendEmail(sendEmailRequest: SendEmailRequest) -> AnyPublisher<EmailSendResponse, ErrorResponse>
    
    func codeCheck(code: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}

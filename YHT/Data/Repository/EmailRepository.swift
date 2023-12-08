//
//  EmailRepository.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Alamofire
import Combine

class EmailRepository: EmailRepositoryProtocol {
    
    func sendEmail(email: String) -> AnyPublisher<EmailSendResponse, ErrorResponse> {
        return Future<EmailSendResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/email",
                       method: .post,
                       parameters: SendEmailRequest(email: email),
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let emailSendResponse = try JSONDecoder().decode(EmailSendResponse.self, from: data)
                        promise(.success(emailSendResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: response.response?.statusCode ?? 500,
                                                             error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500,
                                                    error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
}

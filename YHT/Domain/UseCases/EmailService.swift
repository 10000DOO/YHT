//
//  EmailService.swift
//  YHT
//
//  Created by 이건준 on 12/7/23.
//

import Foundation
import Combine

class EmailService: EmailServiceProtocol {
    
    private let emailRepository: EmailRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(emailRepository: EmailRepositoryProtocol) {
        self.emailRepository = emailRepository
    }
    
    func sendEmail(email: String) -> AnyPublisher<Never, ErrorResponse> {
        return Future<Never, ErrorResponse> { [weak self] promise in
            self?.emailRepository.sendEmail(sendEmailRequest: SendEmailRequest(email: email))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func checkEmailValidation(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func codeCheck(code: String) -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            self?.emailRepository.codeCheck(code: code)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(true))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}

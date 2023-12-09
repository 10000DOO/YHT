//
//  MemberService.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation
import Combine

class MemberService: MemberServiceProtocol {
    
    private let memberRepository: MemberRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(memberRepository: MemberRepositoryProtocol) {
        self.memberRepository = memberRepository
    }
    
    func checkIdValidation(id: String) -> Bool {
        let loginIdRegex = "^.{5,20}$"
        let loginIdPredicate = NSPredicate(format: "SELF MATCHES %@", loginIdRegex)
        return loginIdPredicate.evaluate(with: id)
    }
    
    func checkPasswordValidation(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[-_.~!@<>()$*?])[A-Za-z\\d-_.~!@<>()$*?]{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func signUp(email: String, emailCode: String, id: String, password: String, username: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.memberRepository.join(code: emailCode, signUpRequest: SignUpRequest(loginId: id, password: password, username: username, email: email, field: " "))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(response.data))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}

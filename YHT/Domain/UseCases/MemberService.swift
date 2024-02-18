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
    
    func signIn(id: String, password: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.memberRepository.signIn(signInRequest: SignInRequest(loginId: id, password: password))
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    UserDefaults.standard.set(response.data.username, forKey: "username")
                    
//                    let accessToken = TokenData()
//                    let refreshToken = TokenData()
//                    accessToken.tokenName = "accessToken"
//                    accessToken.tokenContent = "Bearer[\(response.data.accessToken)]"
//                    refreshToken.tokenName = "refreshToken"
//                    refreshToken.tokenContent = "Bearer[\(response.data.refreshToken)]"
//                    
//                    let result = Query.insertToken(accessToken: accessToken, refreshToken: refreshToken)
                    KeychainManager.addItemsOnKeyChain(token: "Bearer[\(response.data.accessToken)]", key: "accessToken")
                    KeychainManager.addItemsOnKeyChain(token: "Bearer[\(response.data.refreshToken)]", key: "refreshToken")
//                    if result != nil {
//                        promise(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])))
//                    }
                    promise(.success(response.data.username))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func findId(code: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.memberRepository.findId(code: code)
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
    
    func changePassowrd(password: String, email: String) -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            self?.memberRepository.changePassword(changePasswordRequest: ChangePasswordRequest(password: password, email: email))
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
    
    func issueNewToken() -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            let refreshToken = try? KeychainManager.searchItemFromKeychain(key: "refreshToken")
            
            self?.memberRepository.reIssueToken(accessToken: accessToken, refreshToken: refreshToken)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        if error.error[0].error == ErrorMessage.expiredRefreshToken.rawValue {
                            promise(.failure(error))
                        }
                    }
                } receiveValue: { response in
                    UserDefaults.standard.set(response.data.username, forKey: "username")
                    
//                    let accessToken = TokenData()
//                    let refreshToken = TokenData()
//                    accessToken.tokenName = "accessToken"
//                    accessToken.tokenContent = "Bearer[\(response.data.accessToken)]"
//                    refreshToken.tokenName = "refreshToken"
//                    refreshToken.tokenContent = "Bearer[\(response.data.refreshToken)]"
//                    
//                    let result = Query.insertToken(accessToken: accessToken, refreshToken: refreshToken)
                    KeychainManager.addItemsOnKeyChain(token: "Bearer[\(response.data.accessToken)]", key: "accessToken")
                    KeychainManager.addItemsOnKeyChain(token: "Bearer[\(response.data.refreshToken)]", key: "refreshToken")
//                    if result != nil {
//                        promise(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])))
//                    }
                    promise(.success(true))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func deleteDiary() -> AnyPublisher<Bool, ErrorResponse> {
        return Future<Bool, ErrorResponse> { [weak self] promise in
            let accessToken = try? KeychainManager.searchItemFromKeychain(key: "accessToken")
            self?.memberRepository.deleteMember(accessToken: accessToken)
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

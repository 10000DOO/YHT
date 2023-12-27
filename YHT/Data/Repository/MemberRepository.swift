//
//  MemberRepository.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation
import Alamofire
import Combine

class MemberRepository: MemberRepositoryProtocol {
    
    func join(code: String, signUpRequest: SignUpRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            var urlComponents = URLComponents(string: ServerInfo.serverURL + "/signup")!
            urlComponents.queryItems = [URLQueryItem(name: "code", value: code)]
            
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = HTTPMethod.post.rawValue
            urlRequest.headers = HTTPHeaders(["Content-Type": "application/json"])
            
            do {
                let encoder = JSONParameterEncoder.default
                urlRequest = try encoder.encode(signUpRequest, into: urlRequest)
            } catch {
            }
            
            AF.request(urlRequest)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let signUpResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                            promise(.success(signUpResponse))
                        } catch {
                            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                                promise(.failure(errorResponse))
                            } else {
                                let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                                promise(.failure(defaultError))
                            }
                        }
                    case .failure(let error):
                        let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        promise(.failure(customError))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func signIn(signInRequest: SignInRequest) -> AnyPublisher<SignInResponse, ErrorResponse> {
        return Future<SignInResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/signin",
                       method: .post,
                       parameters: signInRequest,
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                        promise(.success(signInResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func findId(code: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/find/id",
                       method: .get,
                       parameters: ["code" : code],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let findIdResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(findIdResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func changePassword(changePasswordRequest: ChangePasswordRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/find/pw",
                       method: .patch,
                       parameters: changePasswordRequest,
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let changePassowrdResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(changePassowrdResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func reIssueToken(accessToken: String?, refreshToken: String?) -> AnyPublisher<SignInResponse, ErrorResponse> {
        return Future<SignInResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/token/issue",
                       method: .get,
                       headers: ["Content-Type": "application/json", "Authorization" : accessToken!, "refreshToken" : refreshToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let issuedToken = try JSONDecoder().decode(SignInResponse.self, from: data)
                        promise(.success(issuedToken))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteMember(accessToken: String?) -> AnyPublisher<CommonSuccessResInt, ErrorResponse> {
        return Future<CommonSuccessResInt, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/member/delete",
                       method: .patch,
                       headers: ["Content-Type": "application/json", "Authorization" : accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let deleteSuccess = try JSONDecoder().decode(CommonSuccessResInt.self, from: data)
                        promise(.success(deleteSuccess))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
}

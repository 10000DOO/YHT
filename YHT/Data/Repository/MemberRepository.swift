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
                        let queryResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        print(queryResponse)
                        promise(.success(queryResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            print(errorResponse)
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

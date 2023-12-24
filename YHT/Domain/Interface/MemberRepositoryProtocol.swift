//
//  MemberRepositoryProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/9/23.
//

import Foundation
import Combine

protocol MemberRepositoryProtocol {
    
    func join(code: String, signUpRequest: SignUpRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func signIn(signInRequest: SignInRequest) -> AnyPublisher<SignInResponse, ErrorResponse>
    
    func findId(code: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func changePassword(changePasswordRequest: ChangePasswordRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func reIssueToken(accessToken: String?, refreshToken: String?) -> AnyPublisher<SignInResponse, ErrorResponse>
}

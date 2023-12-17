//
//  DiaryRepository.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import Foundation
import Alamofire
import Combine

class DiaryRepository: DiaryRepositoryProtocol {
    
    func getDiaryList(date: String, accessToken: String?) -> AnyPublisher<DiaryListResponse, ErrorResponse> {
        return Future<DiaryListResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/diary",
                       method: .get,
                       parameters: ["date" : date],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let diaryListResponse = try JSONDecoder().decode(DiaryListResponse.self, from: data)
                        promise(.success(diaryListResponse))
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

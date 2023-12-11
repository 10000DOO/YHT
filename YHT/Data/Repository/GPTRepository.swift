//
//  GPTRepository.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Alamofire
import Combine

class GPTRepository: GPTRepositoryProtocol {
    
    func recommendRoutine(routineRequest: RoutineRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/api/routines",
                       method: .post,
                       parameters: routineRequest,
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let routineResult = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(routineResult))
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

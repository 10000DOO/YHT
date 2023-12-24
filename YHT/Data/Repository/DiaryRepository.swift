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
    
    func getDiaryDetail(date: String, accessToken: String?) -> AnyPublisher<DiaryDetailResponse, ErrorResponse> {
        return Future<DiaryDetailResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/diary/detail",
                       method: .get,
                       parameters: ["date" : date],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let diaryDetailResponse = try JSONDecoder().decode(DiaryDetailResponse.self, from: data)
                        promise(.success(diaryDetailResponse))
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
    
    func addDiary(modifyDiaryRequest: ModifyDiaryRequest, accessToken: String?) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.upload(
                multipartFormData: { multipartFormData in
                    do {
                        let jsonData = try JSONEncoder().encode(modifyDiaryRequest)
                        multipartFormData.append(Data(jsonData), withName: "writeDiaryDto", mimeType: "application/json")
                    } catch {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        promise(.failure(defaultError))
                        return
                    }
                },
                to: ServerInfo.serverURL + "/diary/write",
                method: .post,
                headers: ["Content-Type": "multipart/form-data", "Authorization": accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let addDiarySuccess = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(addDiarySuccess))
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
    
    func modifyDiary(modifyDiaryRequest: ModifyDiaryRequest, accessToken: String?, diaryId: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.upload(
                multipartFormData: { multipartFormData in
                    do {
                        let jsonData = try JSONEncoder().encode(modifyDiaryRequest)
                        multipartFormData.append(Data(jsonData), withName: "writeDiaryDto", mimeType: "application/json")
                    } catch {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        promise(.failure(defaultError))
                        return
                    }
                },
                to: ServerInfo.serverURL + "/diary/edit/\(diaryId)",
                method: .patch,
                headers: ["Content-Type": "multipart/form-data", "Authorization": accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let modifyDiarySuccess = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(modifyDiarySuccess))
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
    
    func deleteDiary(diaryId: Int, accessToken: String?) -> AnyPublisher<DiaryDeleteResponse, ErrorResponse> {
        return Future<DiaryDeleteResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/diary/delete/\(diaryId)",
                       method: .patch,
                       headers: ["Content-Type": "application/json", "Authorization" : accessToken!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let deleteSuccess = try JSONDecoder().decode(DiaryDeleteResponse.self, from: data)
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

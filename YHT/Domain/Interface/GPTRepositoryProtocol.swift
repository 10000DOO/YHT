//
//  GPTRepositoryProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Combine

protocol GPTRepositoryProtocol {
    
    func recommendRoutine(routineRequest: RoutineRequest) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}

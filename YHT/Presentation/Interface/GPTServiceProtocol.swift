//
//  GPTServiceProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Combine

protocol GPTServiceProtocol {
    
    func recommendRoutine(healthPurpose: String, height: Int, weight: Int, divisions: Int) -> AnyPublisher<String, ErrorResponse>
    
    func recommendDiet(healthPurpose: String, height: Int, weight: Int, diet: [String]) -> AnyPublisher<String, ErrorResponse>
    
    func recommendReview(exerciseName: String, muscleName: String) -> AnyPublisher<String, ErrorResponse>
}

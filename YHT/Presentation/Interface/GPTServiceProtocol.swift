//
//  GPTServiceProtocol.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import Foundation
import Combine

protocol GPTServiceProtocol {
    
    func changePassowrd(healthPurpose: String, height: Int, weight: Int, divisions: Int) -> AnyPublisher<String, ErrorResponse>
}

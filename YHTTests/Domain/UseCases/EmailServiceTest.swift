//
//  EmailServiceTest.swift
//  YHTTests
//
//  Created by 이건준 on 1/28/24.
//

import XCTest
import Combine
import YHT

class EmailServiceTests: XCTestCase {
    
    var emailRepository: MockEmailRepository!
    var emailService: EmailService!
    
    override func setUp() {
        super.setUp()
        emailRepository = MockEmailRepository()
        emailService = EmailService(emailRepository: emailRepository)
    }

    func testSendEmailSuccess() {
        // Arrange
        let email = "test@example.com"
        let expectation = expectation(description: "Email sent successfully")
        
        // Act
        let cancellable = emailService.sendEmail(email: email)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Should not fail")
                }
            }, receiveValue: { _ in })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel() // Cleanup
        
        // Additional assertions if needed
    }
    
    func testSendEmailFailure() {
        // Arrange
        let email = "invalid_email"
        let expectation = expectation(description: "Email sending should fail")
        
        // Act
        let cancellable = emailService.sendEmail(email: email)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Should fail")
                case .failure(let error):
                    XCTAssertEqual(error, .invalidEmail)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel() // Cleanup
        
        // Additional assertions if needed
    }
}

// MockEmailRepository for testing purposes
class MockEmailRepository: EmailRepositoryProtocol {
    func sendEmail(sendEmailRequest: SendEmailRequest) -> AnyPublisher<Void, ErrorResponse> {
        // Simulate successful or failed email sending based on your test case
        if sendEmailRequest.email.contains("@") {
            return Just(()).setFailureType(to: ErrorResponse.self).eraseToAnyPublisher()
        } else {
            return Fail(error: .invalidEmail).eraseToAnyPublisher()
        }
    }
}


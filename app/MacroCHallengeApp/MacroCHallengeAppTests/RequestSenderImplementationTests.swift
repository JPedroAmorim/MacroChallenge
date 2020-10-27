//
//  RequestSenderImplementationTests.swift
//  MacroCHallengeAppTests
//
//  Created by João Pedro de Amorim on 27/10/20.
//

import XCTest

class RequestSenderImplementationTests: XCTestCase {
    // MARK: - Test subject
    let testSubject = RequestSenderImplementation()

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    // Nota: Para esse teste funcionar, o backend precisa estar ativo
    func testGetQuestionsForTestRequest_WhenBackendIsUp_shouldReturnQuestions() throws {
       // Given
        let responseExpectation = XCTestExpectation(description: "Questions were retrieved from backend and properly parsed")
        
        let completionHandler: ([Question]) -> Void = { questions in
            
            XCTAssert(questions.count > 0)
            
            responseExpectation.fulfill()
        }
        
        let failureHandler: (String) -> Void = { error in
            XCTFail("Error ocurred with message \(error)")
        }
        
        // When
        testSubject.getQuestionsForTestRequest(testName: "cti2019", testYear: "2019", completion: completionHandler, onFailure: failureHandler)

        // Then
        wait(for: [responseExpectation], timeout: 10.0)
    }
}

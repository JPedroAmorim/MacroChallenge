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
    
    // MARK: - Test cases
    // Nota: Para esse teste funcionar, o backend precisa estar ativo
    func testGetQuestionsForTestRequest_WhenBackendIsUp_shouldReturnQuestions() throws {
       // Given
        let responseExpectation = XCTestExpectation(description: "Questions were retrieved from backend and properly parsed")
        
        let completionHandler: ([Question]?, String?) -> Void = { (questions, error) in
            guard let questionsFromParser = questions else {
                XCTFail("Error ocurred with message \(error!)")
            }
            
            XCTAssert(questionsFromParser.count > 0)
            
            responseExpectation.fulfill()
        }
        
        // When
        testSubject.getQuestionsForTestRequest(testName: "cti2019", testYear: "2019", completion: completionHandler)

        // Then
        wait(for: [responseExpectation], timeout: 10.0)
    }
}

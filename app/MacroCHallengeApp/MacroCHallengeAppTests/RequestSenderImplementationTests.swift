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
        var questionsFromRequest: [Question]?
        var errorString: String?
        
        let completionHandler: ([Question]) -> Void = { questions in
            questionsFromRequest = questions
        }
        
        let failureHandler: (String) -> Void = {error in
            errorString = error
        }
        
        // When
        testSubject.getQuestionsForTestRequest(testName: "cti2019", testYear: "2019", completion: completionHandler, onFailure: failureHandler)
        
        
        // Then
        XCTAssertNil(errorString)
        XCTAssertNotNil(questionsFromRequest)
    }
}

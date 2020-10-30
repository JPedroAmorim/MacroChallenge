//
//  ConverterResultsJSONTests.swift
//  MacroCHallengeAppTests
//
//  Created by Felipe Semissatto on 30/10/20.
//

import SwiftyJSON
import XCTest

class ConverterResultsJSONTests: XCTestCase {
    // MARK: - Setup and teardown methods
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testCreateResultPerTopic_whenGivenValidJSON_shouldGiveValidResultPerTopic() throws {

        // Given
        let inputJSON = createValidMockJSON()
        let testSubject = ConverterResultsJSON()

        // When
        let resultQuestions = try testSubject.createResultPerTopic(json: inputJSON)

        // Then

    }
    
    func createValidMockJSON() -> JSON {
        let arrayDictResultsPerTopic: [[String:String]] = [["topic":"Português",
                                                            "totalPercentageOfCorrectAnswers":"20.0",
                                                            "totalNumberOfCorrectAnswers":"10",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"],
                                                           ["topic":"Matemática",
                                                            "totalPercentageOfCorrectAnswers":"50.0",
                                                            "totalNumberOfCorrectAnswers":"15",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"]
        ]
        let dictValidMock: [String:Any] = ["totalPercentageOfCorrectAnswers":"20.0",
                                           "totalNumberOfQuestions":"50",
                                           "totalNumberOfCorrectAnswers":"45",
                                           "totalNumberOfAnsweredQuestions":"45",
                                           "resultsPerTopic": arrayDictResultsPerTopic]
        
        
        let json: JSON = JSON(dictValidMock)
        
        return json
    }
    
    func createInvalidGeneralResultsMockJSON() -> JSON {
        
        let arrayDictResultsPerTopic: [[String:String]] = [["topic":"Português",
                                                            "totalPercentageOfCorrectAnswers":"20.0",
                                                            "totalNumberOfCorrectAnswers":"10",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"],
                                                           ["topic":"Matemática",
                                                            "totalPercentageOfCorrectAnswers":"50.0",
                                                            "totalNumberOfCorrectAnswers":"15",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"]
        ]
        
        // Retirei a chave totalNumberOfCorrectAnswers
        let dictInvalidGeneralResultsMock: [String:Any] = ["totalPercentageOfCorrectAnswers":"20.0",
                                           "totalNumberOfQuestions":"50",
                                           "totalNumberOfAnsweredQuestions":"45",
                                           "resultsPerTopic": arrayDictResultsPerTopic]
        
        let json: JSON = JSON(dictInvalidGeneralResultsMock)
        
        return json
    }
    
    func createInvalidResultsPerTopicMockJSON() -> JSON {
        
        let arrayInvalidDictResultsPerTopic: [[String:String]] = [["totalPercentageOfCorrectAnswers":"20.0",
                                                            "totalNumberOfCorrectAnswers":"10",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"],
                                                           ["topic":"Matemática",
                                                            "totalPercentageOfCorrectAnswers":"50.0",
                                                            "totalNumberOfCorrectAnswers":"15",
                                                            "totalNumberOfAnsweredQuestions":"30",
                                                            "totalNumberOfQuestions":"30"]
        ]
        
        let dictInvalidMock: [String:Any] = ["totalPercentageOfCorrectAnswers":"20.0",
                                             "totalNumberOfQuestions":"50",
                                             "totalNumberOfCorrectAnswers":"45",
                                             "totalNumberOfAnsweredQuestions":"45",
                                             "resultsPerTopic": arrayInvalidDictResultsPerTopic]
        
        let json: JSON = JSON(dictInvalidMock)
        
        return json
    }
    
    func createEmptyResultsPerTopicMockJSON() -> JSON {
        
        let arrayEmptyDictResultsPerTopic: [[String:String]] = [[:]]
        
        let dictInvalidMock: [String:Any] = ["totalPercentageOfCorrectAnswers":"20.0",
                                             "totalNumberOfQuestions":"50",
                                             "totalNumberOfCorrectAnswers":"45",
                                             "totalNumberOfAnsweredQuestions":"45",
                                             "resultsPerTopic": arrayEmptyDictResultsPerTopic]
        
        let json: JSON = JSON(dictInvalidMock)
        
        return json
    }
}

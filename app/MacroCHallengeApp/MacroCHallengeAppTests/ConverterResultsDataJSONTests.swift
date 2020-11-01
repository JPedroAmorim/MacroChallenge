//
//  ConverterResultsDataJSONTests.swift
//  MacroCHallengeAppTests
//
//  Created by Felipe Semissatto on 30/10/20.
//

import SwiftyJSON
import XCTest

class ConverterResultsDataJSONTests: XCTestCase {
    // MARK: - Setup and teardown methods
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testCreateResultsData_whenGivenValidJSON_shouldGiveValidResultsData() throws {

        // Given
        let inputJSON = createValidMockJSON()
        let testSubject = ConverterResultsDataJSON()

        // When
        let resultsData = try testSubject.createResultsData(json: inputJSON)

        // Then
        var percentageOfCorrectAnswers = ("20.0" as NSString).doubleValue
        var numberOfCorrectAnswers = ("10" as NSString).intValue
        var numberOfAnsweredQuestions = ("30" as NSString).intValue
        var numberOfQuestions = ("30" as NSString).intValue
        let expectedResultPortuguese = ResultsPerTopic(totalPercentageOfCorrectAnswers: percentageOfCorrectAnswers,
                                             totalNumberOfCorrectAnswers: Int(numberOfCorrectAnswers),
                                             totalNumberOfAnsweredQuestions: Int(numberOfAnsweredQuestions),
                                             totalNumberOfQuestions: Int(numberOfQuestions))
        
        percentageOfCorrectAnswers = ("50.0" as NSString).doubleValue
        numberOfCorrectAnswers = ("15" as NSString).intValue
        numberOfAnsweredQuestions = ("30" as NSString).intValue
        numberOfQuestions = ("30" as NSString).intValue
        let expectedResultMath = ResultsPerTopic(totalPercentageOfCorrectAnswers: percentageOfCorrectAnswers,
                                             totalNumberOfCorrectAnswers: Int(numberOfCorrectAnswers),
                                             totalNumberOfAnsweredQuestions: Int(numberOfAnsweredQuestions),
                                             totalNumberOfQuestions: Int(numberOfQuestions))
        
        percentageOfCorrectAnswers = ("90.0" as NSString).doubleValue
        numberOfCorrectAnswers = ("45" as NSString).intValue
        numberOfAnsweredQuestions = ("45" as NSString).intValue
        numberOfQuestions = ("50" as NSString).intValue
        
        let test = Test(name: "cotuca2019", year: "2019", questions: [])

        let expectedResultsData = ResultsData(totalPercentageOfCorrectAnswers: percentageOfCorrectAnswers,
                                              totalNumberOfCorrectAnswers: Int(numberOfCorrectAnswers),
                                              totalNumberOfAnsweredQuestions: Int(numberOfAnsweredQuestions),
                                              totalNumberOfQuestions: Int(numberOfQuestions),
                                              resultsPerTopic: ["Português" : expectedResultPortuguese,
                                                                "Matemática" : expectedResultMath],
                                              test: test,
                                              answeredQuestions: ["20": "B", "10" : "A"],
                                              totalTimeElapsed: "",
                                              correctAnswers: [1, 2, 3],
                                              wrongAnswers: [2, 3, 4, 5])
        
        XCTAssertEqual(resultsData.totalPercentageOfCorrectAnswers, expectedResultsData.totalPercentageOfCorrectAnswers)
        XCTAssertEqual(resultsData.totalNumberOfCorrectAnswers, expectedResultsData.totalNumberOfCorrectAnswers)
        XCTAssertEqual(resultsData.totalNumberOfAnsweredQuestions, expectedResultsData.totalNumberOfAnsweredQuestions)
        XCTAssertEqual(resultsData.totalNumberOfQuestions, expectedResultsData.totalNumberOfQuestions)
        XCTAssertEqual(resultsData.resultsPerTopic, expectedResultsData.resultsPerTopic)
        XCTAssertEqual(resultsData.test.name, expectedResultsData.test.name)
        XCTAssertEqual(resultsData.test.year, expectedResultsData.test.year)
        XCTAssertEqual(resultsData.answeredQuestions, expectedResultsData.answeredQuestions)
        XCTAssertEqual(resultsData.totalTimeElapsed, expectedResultsData.totalTimeElapsed)
        XCTAssertEqual(resultsData.correctAnswers, expectedResultsData.correctAnswers)
        XCTAssertEqual(resultsData.wrongAnswers, expectedResultsData.wrongAnswers)
    }

    func testCreateResultsData_whenGivenInvalidResultsDataMockJSON_shouldGiveError() throws {

        // Given
        let inputJSON = createInvalidMockJSON()
        let testSubject = ConverterResultsDataJSON()

        do {
            // When
            _ = try testSubject.createResultsData(json: inputJSON)

            XCTFail("There is invalid wrong key in results data dictionary, an error was expected")
        }
        catch {
            // Then
            XCTAssert(true)
        }
    }
    
    func testCreateDictResultsPerTopic_whenGivenEmptyResultsPerTopicMockJSON_shouldGiveError() throws {

        // Given
        let inputJSON = createEmptyResultsDataMockJSON()
        let testSubject = ConverterResultsDataJSON()

        do {
            // Given
            _ = try testSubject.createResultsData(json: inputJSON)

            XCTFail("The array dictionary results per topic is empty, an error was expected")
        }
        catch {
            // Then
            XCTAssert(true)
        }
    }
    
    
    func testCreateDict_whenGivenValidDictString_ShouldReturnDict() {
        // Given
        let testSubject = ConverterResultsDataJSON()
        let inputDict = ["20" : "B", "1" : "C", "30" : "D"]
        
        // Given
       let result = testSubject.convertStringInADictionary(text: String(describing: inputDict))
        
        
        
        XCTAssertEqual(result, inputDict)
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
        
        // A string que você tava fazendo o answered questions tava errada.
        let answeredQuestionsAsInputString = String(describing: ["20": "B", "10": "A"])
        
        let dictValidMock: [String:Any] = ["testName":"cotuca2019",
                                           "testYear":"2019",
                                           "totalPercentageOfCorrectAnswers":"90.0",
                                           "totalNumberOfAnsweredQuestions":"45",
                                           "totalNumberOfQuestions":"50",
                                           "totalNumberOfCorrectAnswers":"45",
                                           "correctAnswers":"[1, 2, 3]",
                                           "wrongAnswers":"[2, 3, 4, 5]",
                                           "answeredQuestions": answeredQuestionsAsInputString,
                                           "resultsPerTopic": arrayDictResultsPerTopic]
        
        
        let json: JSON = JSON(dictValidMock)
        
        return json
    }
    
    func createInvalidMockJSON() -> JSON {
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
        
        // Sem a chave totalNumberOfCorrectAnswers
        let dictValidMock: [String:Any] = ["testName":"cotuca2019",
                                           "testYear":"2019",
                                           "totalNumberOfAnsweredQuestions":"45",
                                           "totalNumberOfQuestions":"50",
                                           "totalNumberOfCorrectAnswers":"45",
                                           "correctAnswers":"[1, 2, 3]",
                                           "wrongAnswers":"[2, 3, 4, 5]",
                                           "answeredQuestions":"[\"20\": \"B\", \"10\" : \"A\"]",
                                           "resultsPerTopic": arrayDictResultsPerTopic]
        
        
        let json: JSON = JSON(dictValidMock)
        
        return json
    }
    
    func createEmptyResultsDataMockJSON() -> JSON {
        
        let arrayEmptyDictResultsPerTopic: [[String:String]] = [[:]]
        
        let dictInvalidMock: [String:Any] = ["testName":"cotuca2019",
                                           "testYear":"2019",
                                           "totalNumberOfAnsweredQuestions":"45",
                                           "totalNumberOfQuestions":"50",
                                           "totalNumberOfCorrectAnswers":"45",
                                           "correctAnswers":"[1, 2, 3]",
                                           "wrongAnswers":"[2, 3, 4, 5]",
                                           "answeredQuestions":"[\"20\": \"B\", \"10\" : \"A\"]",
                                           "resultsPerTopic": arrayEmptyDictResultsPerTopic]
        
        let json: JSON = JSON(dictInvalidMock)
        
        return json
    }
}

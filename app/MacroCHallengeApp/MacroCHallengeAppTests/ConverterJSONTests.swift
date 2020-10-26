//
//  ConverterJSONTests.swift
//  MacroCHallengeAppTests
//
//  Created by Joao Flores on 23/10/20.
//

import SwiftyJSON
import XCTest

class ConverterJSONTests: XCTestCase {
	// MARK: - Setup and teardown methods
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testCreateQuestion_whenGivenValidJSON_shouldGiveValidQuestion() throws {

		// Given
		let inputJSON = createValidMockJSON()
		let testSubject = ConverterJSON()

		// When
		let resultQuestion = try testSubject.createQuestion(json: inputJSON)

		// Then
		let expectedOptionsDict  = ["A" : "ExampleOptionA", "B" : "ExampleOptionB", "C": "ExampleOptionC", "D" : "ExampleOptionD"]
		let expectedResult = Question(number: "1", text: "This is a example of text", initialText: "initialText example", images: nil, subtitle: "subtitleExample", options: expectedOptionsDict, answer: "answerTest", topic: "topic")

		guard let result = resultQuestion else {
			XCTFail("Result question falhou a fazer o question")
			return
		}

		XCTAssertEqual(result.number, expectedResult.number)
		XCTAssertEqual(result.options, expectedResult.options)
		XCTAssertEqual(result.images, expectedResult.images)
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

	func createValidMockJSON() -> JSON {

		let json: JSON = JSON([
			"number" : "1",
			"text" : "This is a example of text",
			"initialText" : "initialText example",
			"images" : "URL1@URL2@URL3",
			"subtitle" : "subtitleExample",
			"options" : "A:ExampleOptionA#@B:ExampleOptionB#@C:ExampleOptionC#@D:ExampleOptionD",
			"answer" : "answerTest",
			"topic" : "topic",
		])

		return json
	}
}

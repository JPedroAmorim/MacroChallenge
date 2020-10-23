//
//  ConverterJSONTests.swift
//  MacroCHallengeAppTests
//
//  Created by Joao Flores on 23/10/20.
//

import SwiftyJSON
import XCTest

class ConverterJSONTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		try creatingQuestion()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

	func creatingQuestion() throws {

		let json: JSON = JSON([
			"number" : "1",
			"text" : "This is a example of text",
			"initialText" : "initialText example",
			"images" : "URL1@URL2@URL3",
			"subtitle" : "subtitleExample",
			"options" : "A#ExampleOptionA@B#ExampleOptionB@C#ExampleOptionC@D#ExampleOptionD",
			"answer" : "answerTest",
			"topic" : "topic",

		])

		// Getting a double from a JSON Array
		let question = ConverterJSON().createQuestion(json: json)

		if let quest = question as? Question {
			print(quest.imagesURL!)
		}

	}

}

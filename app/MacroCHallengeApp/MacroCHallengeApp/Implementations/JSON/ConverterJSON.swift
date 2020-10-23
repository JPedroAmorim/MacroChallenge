//
//  ConverterJSON.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 22/10/20.
//

import SwiftyJSON

//class ConverterJSON {
//
//	init() {
//		let json: JSON = JSON([
//			"array": [12.34, 56.78],
//			"users": [
//				[
//					"id": 987654,
//					"info": [
//						"name": "jack",
//						"email": "jack@gmail.com"
//					],
//					"feeds": [98833, 23443, 213239, 23232]
//				],
//				[
//					"id": 654321,
//					"info": [
//						"name": "jeffgukang",
//						"email": "jeffgukang@gmail.com"
//					],
//					"feeds": [12345, 56789, 12423, 12412]
//				]
//			]
//		])
//
//		// Getting a double from a JSON Array
//		json["array"][0].double
//
//		// Getting an array of string from a JSON Array
//		let arrayOfString = json["users"].arrayValue.map({$0["info"]["name"]})
//		print(arrayOfString)
//
//		// Getting a string from a JSON Dictionary
//		json["users"][0]["info"]["name"].stringValue
//
//		// Getting a string using a path to the element
//		let path = ["users", 1, "info", "name"] as [JSONSubscriptType]
//		var name = json["users", 1, "info", "name"].string
//
//		// With a custom way
//		let keys: [JSONSubscriptType] = ["users", 1, "info", "name"]
//		name = json[keys].string
//
//		// Just the same
//		name = json["users"][1]["info"]["name"].string
//
//		// Alternatively
//		name = json["users", 1, "info", "name"].string
//
//		print(json)
//	}
//}


import SwiftyJSON

class ConverterJSON {

	init() {

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
		var question = createQuestion(json: json)

	}

	func createQuestion(json: JSON) -> Question? {
		var number: String
		var text: String
		var initialText: String?
		var subtitle: String?
		var answer: String
		var topic: String

		var images: [UIImage]?
		var imagesString: String

		var options: [String:String]
		var optionsString: String

		print("1")

		if let numberCurrent = json["number"].string {
			number = numberCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let textCurrent = json["text"].string {
			text = textCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let initialTextCurrent = json["initialText"].string {
			initialText = initialTextCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let answerCurrent = json["answer"].string {
			answer = answerCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let topicCurrent = json["topic"].string {
			topic = topicCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let imagesCurrent = json["images"].string {

			imagesString = imagesCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let optionsCurrent = json["options"].string {
			optionsString = optionsCurrent
		}
		else  {
			return nil
		}

		print("1")

		if let opt = handleOptions(text: optionsString) {
			options = opt
		}

//		var question = Question(number: String, text: String, initialText: String?, images: [UIImage]?, subtitle: String?, options: [String : String], answer: String, topic: String)
		print(json)

		return nil
	}

	func handleOptions(text: String) -> [String:String]? {
		var textJoined = text.split(separator: "@")

		var options = [String : String]()

		print("======")
		for option in textJoined  {
			var optionJoined = option.split(separator: "#")

			print(optionJoined)
			if optionJoined.count == 2 {
				options.updateValue(String(optionJoined[1]), forKey: String(optionJoined[0]))
			}
		}

		print(options["A"])

		return options
	}

	func handleImages(text: String) -> [String:String]? {
		var textJoined = text.split(separator: "@")

		var options = [String : String]()

		print("======")
		for option in textJoined  {
			var optionJoined = option.split(separator: "#")

			print(optionJoined)
			if optionJoined.count == 2 {
				options.updateValue(String(optionJoined[1]), forKey: String(optionJoined[0]))
			}
		}

		print(options["A"])

		return options
	}
}

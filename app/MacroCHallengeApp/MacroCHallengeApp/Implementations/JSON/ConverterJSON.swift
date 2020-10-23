//
//  ConverterJSON.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 22/10/20.
//

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
		let question = createQuestion(json: json)

		print(question?.imagesURL!)

	}

	func createQuestion(json: JSON) -> Question? {
		var number: String
		var text: String
		var initialText: String?
		var subtitle: String?
		var answer: String
		var topic: String

		var imagesURLs: [String]

		var options: [String:String]

		if let numberCurrent = json["number"].string {
			number = numberCurrent
		}
		else  {
			return nil
		}

		if let textCurrent = json["text"].string {
			text = textCurrent
		}
		else  {
			return nil
		}

		if let initialTextCurrent = json["initialText"].string {
			initialText = initialTextCurrent
		}
		else  {
			return nil
		}

		if let subtitleCurrent = json["subtitle"].string {
			subtitle = subtitleCurrent
		}
		else  {
			return nil
		}

		if let answerCurrent = json["answer"].string {
			answer = answerCurrent
		}
		else  {
			return nil
		}

		if let topicCurrent = json["topic"].string {
			topic = topicCurrent
		}
		else  {
			return nil
		}

		if let imagesCurrent = json["images"].string {
			if let imgURLs = handleImages(URLs: imagesCurrent) {
				imagesURLs = imgURLs
			}
			else {
				return nil
			}
		}
		else  {
			return nil
		}

		if let optionsCurrent = json["options"].string {
			if let opt = handleOptions(text: optionsCurrent) {
				options = opt
			}
			else {
				return nil
			}
		}
		else  {
			return nil
		}

		let question = Question(number: number, text: text, initialText: initialText, images: nil, subtitle: subtitle, options: options, answer: answer, topic: topic)

		question.updateImagesURL(imagesURL: imagesURLs)

		return question
	}

	func handleOptions(text: String) -> [String:String]? {
		let textJoined = text.split(separator: "@")

		var options = [String : String]()

		for option in textJoined  {
			let optionJoined = option.split(separator: "#")

			print(optionJoined)
			if optionJoined.count == 2 {
				options.updateValue(String(optionJoined[1]), forKey: String(optionJoined[0]))
			}
		}

		if options.isEmpty {
			return nil
		}
		else {
			return options
		}
	}

	func handleImages(URLs: String) -> [String]? {
		let URLsJoined = URLs.split(separator: "@")

		var URLs = [String]()

		for url in URLsJoined  {
			URLs.append(String(url))
		}

		return URLs
	}
}

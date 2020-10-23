//
//  ConverterJSON.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 22/10/20.
//

import SwiftyJSON

class ConverterJSON {

	func createQuestion(json: JSON) -> Any? {
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
		} else  {
			return "invalid number question"
		}

		if let textCurrent = json["text"].string {
			text = textCurrent
		} else  {
			return "invalid text question"
		}

		if let initialTextCurrent = json["initialText"].string {
			initialText = initialTextCurrent
		} else  {
			return "invalid initialText question"
		}

		if let subtitleCurrent = json["subtitle"].string {
			subtitle = subtitleCurrent
		} else  {
			return "invalid subtitle question"
		}

		if let answerCurrent = json["answer"].string {
			answer = answerCurrent
		} else  {
			return "invalid answer question"
		}

		if let topicCurrent = json["topic"].string {
			topic = topicCurrent
		} else  {
			return "invalid topic question"
		}

		if let imagesCurrent = json["images"].string {
			if let imgURLs = handleImages(URLs: imagesCurrent) {
				imagesURLs = imgURLs
			} else {
				imagesURLs = []
			}
		} else  {
			return "invalid images question"
		}

		if let optionsCurrent = json["options"].string {
			if let opt = handleOptions(text: optionsCurrent) {
				options = opt
			} else {
				return "invalid options question"
			}
		} else  {
			return "invalid options question"
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

		if(URLs.isEmpty) {
			return nil
		} else {
			return URLs
		}
	}
}

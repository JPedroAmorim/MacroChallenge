//
//  ConverterJSON.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 22/10/20.
//

import SwiftyJSON
import Foundation

//	MARK: - Error Handling
enum ErrorQuestion: String, Error {

	case noNumber = "Number is nil"
	case noText = "Text is nil"
	case noInitialText = "InitialText is nil"
	case noSubtitle = "Subtitle is nil"
	case noAnswer = "Answer is nil"
	case noTopic = "Topic is nil"
	case noImagesURLs = "ImagesURLs is nil"
	case noOptions = "Options is nil"
	case noOptionsGet = "Options is empty"
}

class ConverterJSON {

	//	MARK: - Convert JSON to Question
	/**
	Método responsável por converter um objeto JSON em um objeto da  classe Question

	How to use?

	do {
		let converterJSON = try ConverterJSON().createQuestion(json: json)
		print(converterJSON)
	}
		catch let error as UserValidationError {
		print(error.rawValue)
	} catch {
		print("Unspecific Error")
	}
	*/

	func createQuestion(json: JSON) throws -> Question? {
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
			throw ErrorQuestion.noNumber
		}

		if let textCurrent = json["text"].string {
			text = textCurrent
		} else  {
			throw ErrorQuestion.noText
		}

		if let initialTextCurrent = json["initialText"].string {
			initialText = initialTextCurrent
		} else  {
			throw ErrorQuestion.noInitialText
		}

		if let subtitleCurrent = json["subtitle"].string {
			subtitle = subtitleCurrent
		} else  {
			throw ErrorQuestion.noSubtitle
		}

		if let answerCurrent = json["answer"].string {
			answer = answerCurrent
		} else  {
			throw ErrorQuestion.noAnswer
		}

		if let topicCurrent = json["topic"].string {
			topic = topicCurrent
		} else  {
			throw ErrorQuestion.noTopic
		}

		if let imagesCurrent = json["images"].string {
			if let imgURLs = handleImages(URLs: imagesCurrent) {
				imagesURLs = imgURLs
			} else {
				imagesURLs = []
			}
		} else  {
			throw ErrorQuestion.noImagesURLs
		}

		if let optionsCurrent = json["options"].string {
			if let opt = handleOptions(text: optionsCurrent) {
				options = opt
			} else {
				throw ErrorQuestion.noOptionsGet
			}
		} else  {
			throw ErrorQuestion.noOptions
		}

		let imagesUIImages = UIImageView()
		imagesUIImages.loadImageUsingCache(withUrl: "https://firebasestorage.googleapis.com/v0/b/roggerapp-64174.appspot.com/o/promotions%2FBacon%20Cheddar.jpg?alt=media&token=66ec189e-06e2-4707-a583-80f4f8fd3bdd")

		let question = Question(number: number, text: text, initialText: initialText, images: [imagesUIImages.image!], subtitle: subtitle, options: options, answer: answer, topic: topic)

		question.updateImagesURL(imagesURL: imagesURLs)

		return question
	}


	func handleOptions(text: String) -> [String:String]? {
		let textJoined = text.components(separatedBy: "#@")

		var options = [String : String]()

		for option in textJoined  {
			let optionText = String(option.dropFirst(2))

			let optionLetter = String(option.prefix(1))

			options.updateValue(optionText, forKey: optionLetter)
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

//
//  Question.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 05/10/20.
//

import Foundation
import UIKit

class Question {
    
    var number: String
    var text: String
    var initialText: String?
    var image: UIImage?
    var subtitle: String?
    var options: [String:String]
    var answer: String
    
    init(number: String, text: String, initialText: String?, image: UIImage?, subtitle: String?, options: [String : String], answer: String) {
        self.number = number
        self.text = text
        self.initialText = initialText
        self.image = image
        self.subtitle = subtitle
        self.options = options
        self.answer = answer
    }
    
}

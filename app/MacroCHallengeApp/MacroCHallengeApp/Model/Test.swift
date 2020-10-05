//
//  Test.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 05/10/20.
//

import Foundation

class Test {
    var name: String
    var year: String
    var questions: [Question]
    
    init(name: String, year: String, questions: [Question]) {
        self.name = name
        self.year = year
        self.questions = questions
    }
}

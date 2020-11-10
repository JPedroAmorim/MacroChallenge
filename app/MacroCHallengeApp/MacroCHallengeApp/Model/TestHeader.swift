//
//  TestHeader.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 26/10/20.
//

import Foundation

class TestHeader {
    private(set) var name: String
    private(set) var year: String
    private(set) var numberOfCorrectAnswersForLastResult: Int
    private(set) var totalNumberOfQuestionsForLastResult: Int
    
    init(name: String, year: String, numberOfCorrectAnswersForLastResult: Int, totalNumberOfOfQuestionsForLastResult: Int) {
        self.name = name
        self.year = year
        self.numberOfCorrectAnswersForLastResult = numberOfCorrectAnswersForLastResult
        self.totalNumberOfQuestionsForLastResult = totalNumberOfOfQuestionsForLastResult
    }
}

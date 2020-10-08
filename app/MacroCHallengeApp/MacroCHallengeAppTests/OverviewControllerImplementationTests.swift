//
//  OverviewControllerImplementationTests.swift
//  MacroCHallengeAppTests
//
//  Created by João Pedro de Amorim on 08/10/20.
//

import XCTest

class OverviewControllerImplementationTests: XCTestCase {
    // MARK: - Setup and teardown methods
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testHasEnded_whenAllCorrect_ShouldGiveRightPercentage() throws {
        // Given
        let testSubject = OverviewViewControllerImplementation(data: prepareMock())
        correctAnswers(toBeInjected: testSubject, questions: prepareMock().questions)
        
        // When
        testSubject.hasEnded()
        
        // Then
        XCTAssertEqual(100.00, testSubject.totalPercentageOfCorrectAnswers)
    }
    
    func testHasEnded_whenHalfCorrect_ShouldGiveRightPercentage() throws {
        // Given
        let testSubject = OverviewViewControllerImplementation(data: prepareMock())
        halfcorrectAnswers(toBeInjected: testSubject, questions: prepareMock().questions)
        
        // When
        testSubject.hasEnded()
        
        // Then
        XCTAssertEqual(50.00, testSubject.totalPercentageOfCorrectAnswers)
    }
    
    func testHasEnded_whenOneThirdCorrect_ShouldGiveRightPercentage() throws {
        // Given
        let testSubject = OverviewViewControllerImplementation(data: prepareMock())
        oneThirdCorrectAnswers(toBeInjected: testSubject, questions: prepareMock().questions)
        
        // When
        testSubject.hasEnded()
        
        // Then
        XCTAssertEqual(33.00, testSubject.totalPercentageOfCorrectAnswers)
    }
    
    
}

// MARK: - Helper methods
func prepareMock() -> Test {
    let possibleAnswers = ["a", "b", "c", "d"]
    var mockQuestions: [Question] = []
    
    for i in 1...30 {
        let question = Question(number: String(i), text: "", initialText: "",
                                image: nil, subtitle: nil, options: [:],
                                answer: possibleAnswers[i % 4])
        mockQuestions.append(question)
    }
    
    let mockTest = Test(name: "", year: "", questions: mockQuestions)
    
    return mockTest
}

func correctAnswers(toBeInjected: OverviewViewControllerProtocol, questions: [Question]) {
    let possibleAnswers = ["a", "b", "c", "d"]
    
    for i in 1...30 {
        if let question = questions.filter({$0.number == String(i)}).first {
            toBeInjected.answerForQuestionWasSubmitted(question: question, answer: possibleAnswers[i % 4])
        }
    }
}

func halfcorrectAnswers(toBeInjected: OverviewViewControllerProtocol, questions: [Question]) {
    let possibleAnswers = ["a", "b", "c", "d"]
    
    for i in 1...15 {
        if let question = questions.filter({$0.number == String(i)}).first {
            toBeInjected.answerForQuestionWasSubmitted(question: question, answer: possibleAnswers[i % 4])
        }
    }
}

func oneThirdCorrectAnswers(toBeInjected: OverviewViewControllerProtocol, questions: [Question]) {
    let possibleAnswers = ["a", "b", "c", "d"]
    
    for i in 1...10 {
        if let question = questions.filter({$0.number == String(i)}).first {
            toBeInjected.answerForQuestionWasSubmitted(question: question, answer: possibleAnswers[i % 4])
        }
    }
}



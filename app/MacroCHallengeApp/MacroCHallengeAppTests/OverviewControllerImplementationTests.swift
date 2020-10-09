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
    
    func testAnswerForQuestionWasSubmmited_whenAllCorrect_ShouldGiveRightNumbersForView() throws {
        // Given
        let testSubject = OverviewViewControllerImplementation(data: prepareMock())
        let mockView = MockView(data: prepareMock(), controller: testSubject)
        testSubject.myView = mockView
        
        // When
        correctAnswers(toBeInjected: testSubject, questions: prepareMock().questions)
        
        // Then
        var expectedResult: [Int] = []
        for i in 1...30 {
            expectedResult.append(i)
        }
        XCTAssertEqual(expectedResult, mockView.questionsAnsweredResult)
    }
    
    func testAnswerForQuestionWasSubmitted_WhenOneThirdCorrect_ShouldGiveRightPercentage() throws {
        // Given
        let testSubject = OverviewViewControllerImplementation(data: prepareMock())
        let mockView = MockView(data: prepareMock(), controller: testSubject)
        testSubject.myView = mockView
        
        // When
        oneThirdCorrectAnswers(toBeInjected: testSubject, questions: prepareMock().questions)
        
        // Then
        let expectedResult: Double = 33.00
        XCTAssertEqual(expectedResult, mockView.percentageResult)
    }
}

// MARK: - Mock classes
class MockView: OverviewViewProtocol {
    required init(data: Test, controller: OverviewViewControllerProtocol) {
        viewController = controller
    }
    
    func updatePercentage(percentage: Double) {
        percentageResult = percentage
    }
    
    func updateAnsweredQuestions(questionsAnswered: [Int]) {
        questionsAnsweredResult = questionsAnswered
    }
    
    var viewController: OverviewViewControllerProtocol
    
    var percentageResult: Double = 0.0
    var questionsAnsweredResult: [Int] = []
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



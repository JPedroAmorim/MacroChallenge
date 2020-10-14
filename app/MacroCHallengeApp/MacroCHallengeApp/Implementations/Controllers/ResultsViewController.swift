//
//  ResultsViewController.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 13/10/20.
//

import UIKit

class ResultsViewController: UIViewController, ResultsViewControllerProtocol {
    // MARK: - Dependencies
    var myView: ResultsViewProtocol?
    
    // MARK: - Private attributes
    private var test: Test
    private var answeredQuestions: [String : String]
    private(set) var resultsData: ResultsData?
    
    // MARK: - Init methods
    required init(test: Test, answeredQuestions: [String : String]) {
        self.test = test
        self.answeredQuestions = answeredQuestions
        super.init(nibName: nil, bundle: nil)
        setupResultsData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupDefaultView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup methods
    private func setupDefaultView() {
        if let resultsData = self.resultsData {
            let defaultView = ResultsViewImplementation(data: resultsData, viewController: self)
            self.myView = defaultView
            self.view = defaultView
        }
    }
    
    
    private func setupResultsData() {
        let totalPercentageOfCorrectAnswers = calculateTotalPercentage()
        let totalNumberOfCorrectAnswers = numberOfCorrectAnswers()
        let totalNumberOfAnsweredQuestions = answeredQuestions.count
        let totalNumberOfQuestions = test.questions.count
        let totalTimeElapsed = "todo" 
        let resultsPerTopic: [String : ResultsPerTopic] = [:]
        
        let resultsData = ResultsData(totalPercentageOfCorrectAnswers: totalPercentageOfCorrectAnswers,
                                      totalNumberOfCorrectAnswers: totalNumberOfCorrectAnswers,
                                      totalNumberOfAnsweredQuestions: totalNumberOfAnsweredQuestions,
                                      totalNumberOfQuestions: totalNumberOfQuestions,
                                      resultsPerTopic: resultsPerTopic,
                                      test: test,
                                      answeredQuestions: answeredQuestions,
                                      totalTimeElapsed: totalTimeElapsed)
        self.resultsData = resultsData
    }
    
    // MARK: - ResultsViewControllerProtocol methods
    func questionWasSubmitted(_ question: Question) {
        
    }
    
    /**
     
     Calcula a porcentagem total de acertos na prova (questões corretas/questões totais).
     
     - returns A porcentagem de acertos como um double arredondado (exemplo: 44.00)
     
     */
    
    private func calculateTotalPercentage() -> Double {
        let correctAnswers = numberOfCorrectAnswers()
        let totalNumberOfQuestions = test.questions.count
        
        let doubleValue = Double(correctAnswers) / Double(totalNumberOfQuestions)
        
        let roundedValue = (doubleValue * 100).rounded()
        
        return roundedValue
    }
    /**
     
     Calcula o número de questões corretas em uma prova.
     
     - returns A quantidade de questões corretas
     
     */
    
    private func numberOfCorrectAnswers() -> Int {
        let testQuestions = test.questions
        var correctAnswers: Int = 0
        
        for (questionNumber, answer) in answeredQuestions {
            if let question = testQuestions.filter({ $0.number == questionNumber }).first {
                if question.answer == answer {
                    correctAnswers += 1
                }
            }
        }
        return correctAnswers
    }
}

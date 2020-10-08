//
//  OverviewViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewControllerImplementation: UIViewController, OverviewViewControllerProtocol {
    // MARK: - Dependencies
    var myView: OverviewViewProtocol?
    var questionController: QuestionViewControllerProtocol?
    
    // MARK: - Private attributes
    private var data: Test
    private var questionsAnswered: [String:String] = [:]
    private(set) var totalPercentageOfCorrectAnswers: Double = 0.0
    
    // MARK: - Init methods
    required init(data: Test) {
        self.data = data

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        setupDefaultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup methods
    private func setupDefaultView() {
        let defaultView = OverviewViewImplementation(data: self.data, controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
    
    private func setupDefaultQuestionController() {
        // TODO: Depois de mergear com o papoti, implementar isso daqui.
    }
    
    // MARK: - OverviewViewControllerProtocol methods
    func questionWasSubmitted(_ question: Question) {
        guard let questionController = self.questionController else { return }
        guard let navController = self.navigationController else { return }
        
        questionController.displayQuestion(question)
        
        if let questionControllerAsUIViewController = questionController as? UIViewController {
            navController.pushViewController(questionControllerAsUIViewController, animated: true)
        }
    }
    
    func answerForQuestionWasSubmitted(question: Question, answer: String) {
        questionsAnswered[question.number] = answer
    }
    
    func hasEnded() {
        totalPercentageOfCorrectAnswers = calculateTotalPercentage()
    }
    
    // MARK: - Private methods
    
    /**
     
     Calcula a porcentagem total de acertos na prova (questões corretas/questões totais).
     
     - returns A porcentagem de acertos como um double arredondado (exemplo: 44.00)
     
     */
    private func calculateTotalPercentage() -> Double {
        let testQuestions = data.questions
        let totalNumberOfQuestions = data.questions.count
        var correctAnswers: Int = 0
        
        for (questionNumber, answer) in questionsAnswered {
            if let question = testQuestions.filter({ $0.number == questionNumber }).first {
                if question.answer == answer {
                    correctAnswers += 1
                }
            }
        }
        
        let doubleValue = Double(correctAnswers) / Double(totalNumberOfQuestions)
        
        let roundedValue = (doubleValue * 100).rounded()
        
        return roundedValue
    }
}

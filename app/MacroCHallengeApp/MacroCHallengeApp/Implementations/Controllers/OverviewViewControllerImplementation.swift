//
//  OverviewViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewControllerImplementation: UIViewController, OverviewViewControllerProtocol {
    func hasBegun() {
        
    }
    
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
        setupDefaultQuestionController()

		self.title = data.name
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Iniciar", style: .plain, target: self, action: #selector(addTapped))
    }

	override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
		if let view = self.myView {
			view.updateFrame()
		}
	}

	@objc func addTapped() {
		if let view = self.myView {
			view.changeStatusSimulator()
		}
	}
	
    // MARK: - Setup methods
    private func setupDefaultView() {
        let defaultView = OverviewViewImplementation(data: self.data, controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
    
    private func setupDefaultQuestionController() {
        let defaultQuestionController = QuestionViewControllerImplementation(data: data.questions, parentController: self)
        self.questionController = defaultQuestionController
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
        updateView()
    }
    
    func questionWasUnsubmitted(question: Question) {
        questionsAnswered[question.number] = nil
        updateView()
    }
    
    func hasEnded() {
        totalPercentageOfCorrectAnswers = calculateTotalPercentage()
        if let navCon = self.navigationController {
            let resultsVC = ResultsViewController(test: data, answeredQuestions: questionsAnswered)
            navCon.pushViewController(resultsVC, animated: true)
        }
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
    
    /**
     
     Mapeia as chaves de um dicionário para um vetor de inteiros. Caso ele não consiga mapear a chave, o resultado é zero.
     
     - parameter dict O dicionário que será mapeado
     - returns Um vetor de inteiros com as chaves do dicionário como valores
     
     */
    private func dictKeysAsIntArray(_ dict: [String:String]) -> [Int] {
        return Array(dict.keys).map { (value) -> Int in
            if let integerKey = Int(value) {
                return integerKey
            } else {
                return 0
            }
        }
    }

    /**
     
     Calcula o progresso feito (questões respondidas/questões totais) na forma de um Double arredondado que representa a porcentagem.
     
     - returns O valor arredondado do progresso em porcentagem (exemplo: 33.00)
     
     */
    private func calculateProgress() -> Double {
        let doubleValue: Double =  Double(questionsAnswered.count) / Double(data.questions.count)
        return (doubleValue * 100).rounded()
    }
    
    /**
     
     Atualiza o view sobre o status de questões respondidas/não respondidas.
     
     */
    
    private func updateView() {
        let questionsAnsweredNumbersSorted: [Int] = dictKeysAsIntArray(questionsAnswered).sorted()
        myView?.updateAnsweredQuestions(questionsAnswered: questionsAnsweredNumbersSorted)
        let progressAsPercentage = calculateProgress()
        myView?.updatePercentage(percentage: progressAsPercentage)
        myView?.updateCurrentQuestionsLabel(questionsAnswered: questionsAnswered.count)
    }
}

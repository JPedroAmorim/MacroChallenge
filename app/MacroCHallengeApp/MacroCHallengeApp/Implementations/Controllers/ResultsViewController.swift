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
    private var correctUserAnswers: [Int] = []
    private var wrongUserAnswers: [Int] = []
    
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
        let totalNumberOfCorrectAnswers = getTotalNumberOfCorrectAnswers()
        let totalNumberOfQuestions = test.questions.count
        let totalPercentageOfCorrectAnswers = calculatePercentage(correctAnswers: totalNumberOfCorrectAnswers ,
                                                                  totalNumberOfQuestions: totalNumberOfQuestions)
        let totalNumberOfAnsweredQuestions = answeredQuestions.count
        let totalTimeElapsed = "todo" 
        let resultsPerTopic: [String : ResultsPerTopic] = generateResultsPerTopicMock()
        
        generateCorrectAndWrongUserAnswersAsIntArray()
        
        let resultsData = ResultsData(totalPercentageOfCorrectAnswers: totalPercentageOfCorrectAnswers,
                                      totalNumberOfCorrectAnswers: totalNumberOfCorrectAnswers,
                                      totalNumberOfAnsweredQuestions: totalNumberOfAnsweredQuestions,
                                      totalNumberOfQuestions: totalNumberOfQuestions,
                                      resultsPerTopic: resultsPerTopic,
                                      test: test,
                                      answeredQuestions: answeredQuestions,
                                      totalTimeElapsed: totalTimeElapsed,
                                      correctAnswers: correctUserAnswers,
                                      wrongAnswers: wrongUserAnswers)
        self.resultsData = resultsData
    }
    
    // MARK: - ResultsViewControllerProtocol methods
    func questionWasSubmitted(_ question: Question) {
        
    }
    
    /**
     
     Calcula a porcentagem de acertos(questões corretas/questões totais).
     
     - returns A porcentagem de acertos como um double arredondado (exemplo: 44.00)
     
     */
    
    private func calculatePercentage(correctAnswers: Int, totalNumberOfQuestions:Int) -> Double {
        let doubleValue = Double(correctAnswers) / Double(totalNumberOfQuestions)
        
        let roundedValue = (doubleValue * 100).rounded()
        
        return roundedValue
    }
    
    /**
     
     Calcula o número de questões corretas em uma prova.
     
     - returns A quantidade de questões corretas
     
     */
    
    private func getTotalNumberOfCorrectAnswers() -> Int {
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
    
    // TODO: Remover isso daqui.
    /**
     
     Faz um mock do parâmetro resultsPerTopic, parâmetro de resultsData
     
     - returns Um mock de resultsPerTopic
     
     */
    private func generateResultsPerTopicMock() -> [String : ResultsPerTopic] {
        var resultsPerTopic: [String : ResultsPerTopic] = [:]
        
        let mathTotalCorrect = 30
        let mathTotalAnswered = 40
        let mathTotalNumber = 60
        let mathPercentage = calculatePercentage(correctAnswers: mathTotalCorrect,
                                                 totalNumberOfQuestions: mathTotalNumber)
        
        let mathResult = ResultsPerTopic(totalPercentageOfCorrectAnswers: mathPercentage,
                                         totalNumberOfCorrectAnswers: mathTotalCorrect,
                                         totalNumberOfAnsweredQuestions: mathTotalAnswered,
                                         totalNumberOfQuestions: mathTotalNumber)
        
        resultsPerTopic["Matemática"] = mathResult
        
        let physicsTotalCorrect = 15
        let physicsTotalAnswered = 40
        let physicsTotalNumber = 60
        let physicsPercentage = calculatePercentage(correctAnswers: physicsTotalCorrect,
                                                    totalNumberOfQuestions: physicsTotalNumber)
        
        let physicsResult = ResultsPerTopic(totalPercentageOfCorrectAnswers: physicsPercentage,
                                            totalNumberOfCorrectAnswers: physicsTotalCorrect,
                                            totalNumberOfAnsweredQuestions: physicsTotalAnswered,
                                            totalNumberOfQuestions: physicsTotalNumber)
        
        resultsPerTopic["Física"] = physicsResult
        
        
        return resultsPerTopic
    }
    
    /**
     
     Inicializa as variáveis de classe correctUserAnswers e wrongUserAnswers
     
     */
    
    private func generateCorrectAndWrongUserAnswersAsIntArray() {
        let testQuestions = test.questions
        
        for (questionNumber, answer) in answeredQuestions {
            if let question = testQuestions.filter({ $0.number == questionNumber }).first {
                if let questionNumberAsInt = Int(questionNumber) {
                    if question.answer == answer {
                        correctUserAnswers.append(questionNumberAsInt)
                    }
                }
            }
        }
        
        correctUserAnswers.sort()
        
        for question in test.questions {
            if let questionNumberAsInt = Int(question.number) {
                if !correctUserAnswers.contains(questionNumberAsInt) {
                    wrongUserAnswers.append(questionNumberAsInt)
                }
            }
        }
        
        wrongUserAnswers.sort()
    }
}

//
//  HistoricViewController.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import UIKit

class HistoricViewControllerImplementation: UIViewController,  HistoricViewControllerProtocol, OverviewViewControllerProtocol {
    
    // MARK: - OverviewViewProtocol methods
    required init(data: Test) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func questionWasSubmitted(_ question: Question) {}
    
    func answerForQuestionWasSubmitted(question: Question, answer: String) {}
    
    func questionWasUnsubmitted(question: Question) {}
    
    func hasBegun() {}
    
    func hasEnded() {}
    
    var myView: OverviewViewProtocol?
    
    var questionController: QuestionViewControllerProtocol?
    
    var myHistoricView: HistoricViewProtocol?
    var schools: SchoolsProtocol?
    
    let requestSender = RequestSenderImplementation()
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        setupDefaultSchoolsImplementation()
        getDataForViewAndSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Histórico"
    }
    
    // MARK: - Setup methods
    private func setupDefaultSchoolsImplementation() {
        self.schools = SchoolsServiceManager()
    }
    
    private func setupDefaultViewImplementation() {
        if let data = schools?.getSchools() {
            let defaultView = HistoricViewImplementation(data: data, controller: self)
            self.myHistoricView = defaultView
            self.view = defaultView
        }
    }
    
    private func getDataForViewAndSetupView() {
        self.view = LoadingView(message: "Carregando as escolas...",
                                error: false)
        
        requestSender.getSchoolAndTestHeaders { schools, error in
            guard let schoolsArray = schools else {
                let errorView = LoadingView(message: "Erro ao carregar as escolas :(",
                                            error: true)
                self.view = errorView
                return
            }
            
            let defaultView = HistoricViewImplementation(data: schoolsArray, controller: self)
            self.myHistoricView = defaultView
            self.view = defaultView
        }
    }
    
    // MARK: - HistoricViewControllerProtocol methods
    
    
    // obs: do jeito q ta agora so mostra o ultimo teste feito
    func testWasSubmitted(_ test: TestHeader) {
        let historicView = self.view
        self.view = LoadingView(message: "Carregando sua prova ...",
                                error: false)
        requestSender.getQuestionsAndAnsweredQuestions(testName: test.name , testYear: test.year) { questions, answeredQuestions, error in
            if let testQuestions = questions, let answeredQuestionsForTest = answeredQuestions {
                let testFromTestHeader = Test(name: test.name, year: test.year, questions: testQuestions)
                
                let questionsVC = QuestionViewControllerImplementation(data: testQuestions, parentController: self)
                
                questionsVC.shouldDisplayAnswer = true
                questionsVC.answeredQuestions = answeredQuestionsForTest
                
                if let navController = self.navigationController {
                    let resultsVC = ResultsViewController(test: testFromTestHeader, answeredQuestions: answeredQuestionsForTest, timeElapsed: "00:00", questionController: questionsVC, shouldSendResults: false)
                    navController.pushViewController(resultsVC, animated: true)
                }
                
                self.view = historicView
            } else {
                if let navController = self.navigationController {
                    let errorView = LoadingView(message: "Erro ao carregar sua prova :(",
                                                error: true)
                    let vc = UIViewController()
                    vc.view = errorView
                    navController.pushViewController(vc, animated: false)
                }
                self.view = historicView
            }
            
            
        }
    }
}


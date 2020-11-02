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
        setupDefaultViewImplementation()
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
    
    // MARK: - HistoricViewControllerProtocol methods
    
    
    // obs: do jeito q ta agora so mostra o ultimo teste feito
    func testWasSubmitted(_ test: TestHeader) {
        myHistoricView?.startActivity()
        requestSender.getQuestionsAndAnsweredQuestions(testName: test.name , testYear: test.year) { questions, answeredQuestions, error in
            self.myHistoricView?.stopActivity()
            guard let testQuestions = questions, let answeredQuestionsForTest = answeredQuestions else {
                let alert = UIAlertController(title: "Erro",
                                              message: "Falha ao carregar resultado, verifique sua conexão",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let testFromTestHeader = Test(name: test.name, year: test.year, questions: testQuestions)
            
            let questionsVC = QuestionViewControllerImplementation(data: testQuestions, parentController: self)
            
            questionsVC.shouldDisplayAnswer = true
            questionsVC.answeredQuestions = answeredQuestionsForTest
            
            if let navController = self.navigationController {
                let resultsVC = ResultsViewController(test: testFromTestHeader, answeredQuestions: answeredQuestionsForTest, timeElapsed: "00:00", questionController: questionsVC, shouldSendResults: false)
                navController.pushViewController(resultsVC, animated: true)
            }
        }
    }
}


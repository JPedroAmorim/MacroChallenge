//
//  HistoricViewController.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import UIKit
import AuthenticationServices

class HistoricViewControllerImplementation: UIViewController,  HistoricViewControllerProtocol, OverviewViewControllerProtocol {
    // MARK: - Variables
    var isLoggedIn = false
    
    // MARK: - OverviewViewProtocol methods
    required init(data: Test) {
        super.init(nibName: nil, bundle: nil)
    }
    
    var controlCount = 0
    
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
        if isLoggedIn {
        let defaultUIView = UIView(frame: CGRect.zero)
        defaultUIView.backgroundColor = .green
        self.view = defaultUIView
        setupDefaultSchoolsImplementation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataForViewAndSetupView()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userIsLoggedIn()
        navigationItem.title = "Histórico"
    }
    
    // MARK: - Private Methods
    
    /**
     
     Método responsável verifica se o usuário já logou antes ou não.
     
     - return: true se o usuário está logado, false caso contrário.
     
     */
    private func userIsLoggedIn() {
        if let userIdentifier = UserDefaults.standard.string(forKey: "User") {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    DispatchQueue.main.async {
                        self.setupDefaultSchoolsImplementation()
                        self.setupDefaultViewImplementation()
                        self.isLoggedIn = true
                    }
                case .revoked, .notFound:
                    DispatchQueue.main.async {
                        self.pushLoginView()
                    }
                default:
                    break
                }
            }
        } else {
            self.pushLoginView()
        }
    }
    
    /**
     
     Método responsável que mostra a tela de login apenas quando o usuário na oestá logado.
     
     */
    
    private func pushLoginView() {
        let controller = LoginViewControllerImplementation(message: "Histórico")
        if let navController = self.navigationController {
            navController.pushViewController(controller, animated: false)
        }
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
        
        // Display loading
        let loadingView = LoadingView(message: "Carregando as provas realizadas...",
                                      error: false,
                                      frame: self.view.frame)
        
        loadingView.frame = self.view.frame
        self.view.addSubview(loadingView)
        self.view.bringSubviewToFront(loadingView)
        
        // Send request
        requestSender.getSchoolAndTestHeaders { schools, error in
            
            // Remove loading view
            loadingView.removeFromSuperview()
            
            guard let schoolsArray = schools else {
                
                // Display error message
                let errorView = LoadingView(message: "Erro ao carregar as escolas :(",
                                            error: true,
                                            frame: self.view.frame)
                self.view.addSubview(errorView)
                return
            }

            // Process return
            let schoolsArrayFiltered = schoolsArray.filter {$0.tests.first?.numberOfCorrectAnswersForLastResult != -1}

            // Display historic view
            let historicView = HistoricViewImplementation(data: schoolsArrayFiltered, controller: self)
            historicView.frame = self.view.frame

            self.view.addSubview(historicView)
            self.view.bringSubviewToFront(historicView)
        }
    }
    
    // MARK: - HistoricViewControllerProtocol methods
    
    
    // obs: do jeito q ta agora so mostra o ultimo teste feito
    func testWasSubmitted(_ test: TestHeader) {
        let historicView = self.view
        self.view = LoadingView(message: "Carregando sua prova ...",
                                error: false,
                                frame: CGRect.zero)
        
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
                                                error: true,
                                                frame: CGRect.zero)
                    let vc = UIViewController()
                    vc.view = errorView
                    navController.pushViewController(vc, animated: false)
                }
                self.view = historicView
            }
            
            
        }
    }
}


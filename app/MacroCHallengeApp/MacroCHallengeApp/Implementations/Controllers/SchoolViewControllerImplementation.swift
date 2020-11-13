//
//  SchoolViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewControllerImplementation: UIViewController, SchoolViewControllerProtocol {
    
    // MARK: - Dependencies
    var myView: SchoolViewProtocol?
    
    // MARK: - Private attributes
    private var data: School
    private var requestSender = RequestSenderImplementation()
    
    // MARK: - Init methods
    required init(data: School) {
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
        navigationItem.title = data.name
    }
    
    // MARK: - Setup methods
    private func setupDefaultView() {
        let defaultView = SchoolViewImplementation(data: self.data, controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
    
    // MARK: - SchoolViewControllerProtocol methods
    func testWasSubmitted(_ test: TestHeader) {
        let historicView = self.view
        self.view = LoadingView(message: "Carregando a prova ...",
                                error: false,
                                frame: CGRect.zero)
        requestSender.getQuestionsForTestRequest(
            testName: test.name,
            testYear: test.year,
            completion: { questions, error in
                
                if let questionsArray = questions {
                    if let navController = self.navigationController {
                        let testAsTestType = Test(name: test.name, year: test.year, questions: questionsArray)
                        let overviewViewController = OverviewViewControllerImplementation(data: testAsTestType)
                        navController.pushViewController(overviewViewController, animated: true)
                    }
                    self.view = historicView
                } else {
                    if let navController = self.navigationController {
                        let errorView = LoadingView(message: "Erro ao carregar a prova :(",
                                                    error: true,
                                                    frame: CGRect.zero)
                        let vc = UIViewController()
                        vc.view = errorView
                        navController.pushViewController(vc, animated: false)
                    }
                    self.view = historicView
                }
                
                
            })
    }
    
    func questionWasSubmitted(topic: String) {
        let historicView = self.view
        self.view = LoadingView(message: "Carregando a prova ...",
                                error: false,
                                frame: CGRect.zero)
        
        var errorHasOcurred = false
        
        let topicStr: String = { () -> String in
            switch topic{
            case "Português":
                return "pt"
            case "Matemática":
                return "m"
            case "Ciências Naturais":
                return "cn"
            case "Química":
                return "q"
            case "História":
                return "h"
            case "Biologia":
                return "b"
            case "Geografia":
                return "g"
            case "Física":
                return "f"
            default:
                return ""
            }
                
        }()
        requestSender.getQuestionsForQuestionsRequest(
            testName: self.data.name,
            topic: topicStr,
            completion: { questions, error in
                if let questionsArray = questions {
                    var i = 0
                    let finalQuestionArray = questionsArray.map({(question: Question) -> Question in
                        i += 1
                        return Question(number: String(i),
                                       text: question.text,
                                       initialText: question.initialText,
                                       images: question.images,
                                       subtitle: question.subtitle,
                                       options: question.options,
                                       answer: question.answer,
                                       topic: question.topic)
                      
                    })
                    if !errorHasOcurred, let navController = self.navigationController {
                        let testAsTestType = Test(name: "Questões \(self.data.tests[0].name)",
                                                  year: "",
                                                  questions: finalQuestionArray)
                        let overviewViewController = OverviewViewControllerImplementation(data: testAsTestType)
                        navController.pushViewController(overviewViewController, animated: true)
                        self.view = historicView
                    } else {
                        if let navController = self.navigationController {
                            let errorView = LoadingView(message: "Erro ao carregar a questões :(",
                                                        error: true,
                                                        frame: CGRect.zero)
                            let vc = UIViewController()
                            vc.view = errorView
                            navController.pushViewController(vc, animated: false)
                            self.view = historicView
                        }
                    }
                } else {
                    print("\(error ?? "ziko")")
                    errorHasOcurred = true
                }
            })
        
    }
    
    func noticeWasSubmitted(_ nameSchool: String,_ notice: Notice) {
        if let navController = self.navigationController {
            let overviewViewController = NoticeViewControllerImplementation(data: notice)
            navController.pushViewController(overviewViewController, animated: true)
        }
    }
}


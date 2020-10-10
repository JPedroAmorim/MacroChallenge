//
//  QuestionViewController.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 06/10/20.
//

import UIKit

class QuestionViewControllerImplementation: UIViewController, QuestionViewControllerProtocol {
    // MARK: - Dependencies
    var myView: QuestionViewProtocol?
    
    // MARK: - Private attributes
    private var data: [Question]
    private var currentQuestionIndex: Int
    var chosenOption: String? // Ver se isso aqui é privado mesmo
    
    // MARK: - Init methods
    required init(data: [Question]) {
        self.data = data
        self.currentQuestionIndex = 0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavTitle(index: data[currentQuestionIndex].number)
    }
    
    // MARK: - QuestionsViewControllerProtocolMethods
    func nextWasSubmitted() {
        if currentQuestionIndex < data.count - 1 {
            currentQuestionIndex += 1
            myView?.overwrite(data: data[currentQuestionIndex])
            setNavTitle(index: data[currentQuestionIndex].number)
        }
    }
    
    func previousWasSubmitted() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            myView?.overwrite(data: data[currentQuestionIndex])
            setNavTitle(index: data[currentQuestionIndex].number)
        }
    }
    
    func displayQuestion(_ question: Question) {
        guard let questionNumberAsString = data.filter({$0.number == question.number}).first?.number else {
            return
        }
        
        guard let questionNumberAsInteger = Int(questionNumberAsString) else {
            return
        }
        
        currentQuestionIndex = questionNumberAsInteger - 1
        
        myView?.overwrite(data: data[currentQuestionIndex])
    }
    
    // MARK: - Métodos privados
    /**
     
     Dá display na primeira questão do array de questões
     
     */
    private func setupDefaultView() { 
        let defaultView = QuestionViewImplementation(data: data[currentQuestionIndex], controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
    
    /**
     
     Seta o título da navbar de acordo com o parâmetro index
     
     - parameter index: Índice da questão
     
     */
    private func setNavTitle(index: String) {
        guard let nav = self.navigationController else {return}
        nav.navigationItem.title = "Questão " + index
    }
}

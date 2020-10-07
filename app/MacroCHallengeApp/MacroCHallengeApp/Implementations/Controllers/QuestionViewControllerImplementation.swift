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
    
    // MARK: - Setup methods
    private func setupDefaultView() { 
        let defaultView = QuestionViewImplementation(data: self.data[self.currentQuestionIndex], controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
    
    // MARK: - SchoolViewControllerProtocol methods
    func nextWasSubmitted() {
        currentQuestionIndex += 1
        myView?.overwrite(data: self.data[self.currentQuestionIndex])
    }
    
    func previousWasSubmitted() {
        currentQuestionIndex -= 1
        myView?.overwrite(data: self.data[self.currentQuestionIndex])
    }
}

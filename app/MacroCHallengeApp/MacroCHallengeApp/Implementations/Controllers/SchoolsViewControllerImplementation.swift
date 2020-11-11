//
//  SchoolsViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit
import SwiftyJSON

class SchoolsViewControllerImplementation: UIViewController, SchoolsViewControllerProtocol {
    
    // MARK: - Dependencies
    var myView: SchoolsViewProtocol?
    var schoolsManager: SchoolsProtocol?
    private let requestSender = RequestSenderImplementation()
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        setupDefaultSchoolsImplementation()
        getDataForViewAndSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Colégios"
    }
    
    // MARK: - Setup methods
    private func setupDefaultSchoolsImplementation() {
        self.schoolsManager = SchoolsServiceManager()
    }
    
    private func setupDefaultViewImplementation() {
        if let data = schoolsManager?.getSchools() {
            let defaultView = SchoolsViewImplementation(data: data, controller: self)
            self.myView = defaultView
            self.view = defaultView
        }
    }
    
    private func getDataForViewAndSetupView() {
        self.view = LoadingView(message: "Carregando as escolas...",
                                error: false,
                                frame: CGRect.zero)
        
        requestSender.getSchoolAndTestHeaders { schools, error in 
            guard let schoolsArray = schools else {
                let errorView = LoadingView(message: "Erro ao carregar as escolas :(",
                                            error: true,
                                            frame: CGRect.zero)
                self.view = errorView
                return
            }
            
            let defaultView = SchoolsViewImplementation(data: schoolsArray, controller: self)
            self.myView = defaultView
            self.view = defaultView
        }
    }
    
    // MARK: - SchoolViewControllerProtocol methods
    func schoolWasSubmitted(_ school: School) {
        if let navController = self.navigationController {
            let schoolViewController = SchoolViewControllerImplementation(data: school)
            navController.pushViewController(schoolViewController, animated: true)
        }
    }
}


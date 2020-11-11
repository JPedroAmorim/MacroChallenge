//
//  LoginViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/11/20.
//

import Foundation
import AuthenticationServices

class LoginViewControllerImplementation: UIViewController,  LoginViewControllerProtocol {
    // MARK: - Dependencies
    var myView: LoginViewProtocol?
    let requestSender = RequestSenderImplementation()
    
    // MARK: - Private attributes
    
    
    // MARK: - Lifecycle methods
    required init() {
        super.init(nibName: nil, bundle: nil)
        self.view = LoginViewImplementation(controller: self)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    
    // MARK: - LoginViewControllerProtocol methods
    func addNewUser(_ userIdentifier: String) {
        // Adicionando usuário no UserDefaults
        UserDefaults.standard.set(userIdentifier, forKey: "User")
        
        
        
    }
    
    func checkUserExistence(_ userIdentifier: String) {
        
    }
}

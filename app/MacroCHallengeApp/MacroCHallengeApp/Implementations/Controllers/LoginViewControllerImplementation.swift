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
    required init(controller: LoginViewControllerProtocol) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    
    // MARK: - LoginViewControllerProtocol methods
    func addNewUser(_ user: ASAuthorizationAppleIDCredential) {
        
    }
    
    func checkUserExistence(_ user: ASPasswordCredential) {
        self.view = LoadingView(message: "Validando sua conta ...",
                                error: false)
//        requestSender.getAccountExistance(user: user, completion: (completion: {generalResults, topicsResults, err in
//
//            if let general = generalResults, let topics = topicsResults {
//                let defaultView = LoginViewImplementation(controller: self)
//
//                self.myView = defaultView
//                self.view = defaultView
//            } else {
//                self.view = LoadingView(message: "Sua conta é inválida :(",
//                                        error: true)
//            }
//
//        })
    }
}

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
    
    // MARK: - Lifecycle methods
    required init(message: String) {
        super.init(nibName: nil, bundle: nil)
        self.view = LoginViewImplementation(message: "Para ver \(message), faça o login com sua conta Apple ;)", controller: self)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    /**
     
     Método responsável por chamar a tela logo após do usuário realizar seu primeiro login.
     
     - parameter item: número que dá o contexto da tela (1, se está na tela de métricas; 2, se está na tela de histórico).
     
     */
    private func pushController(_ item: Int) {
        switch item {
        case 1: // Métricas Gerais
            let controller = MetricsViewControllerImplementation()
            if let navController = self.navigationController {
                navController.setViewControllers([controller], animated: false)
            }
            break
        case 2: // Histórico
            let controller = HistoricViewControllerImplementation()
            if let navController = self.navigationController {
                navController.setViewControllers([controller], animated: false)
            }
            break
        default:
            print("Another tab was selected")
        }
    }
    
    // MARK: - LoginViewControllerProtocol methods
    func addNewUser(_ userIdentifier: String) {
        // Adicionando usuário no UserDefaults
        UserDefaults.standard.set(userIdentifier, forKey: "User")
        
        
        self.navigationController?.popViewController(animated: true)
        if let item = tabBarController?.selectedIndex {
            pushController(item)
        }
    }
    
    func checkUserExistence(_ userIdentifier: String) {
        
    }
}

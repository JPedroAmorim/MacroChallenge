//
//  LoginViewControllerProtocol.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/11/20.
//

import Foundation
import AuthenticationServices

protocol LoginViewControllerProtocol {
    /**
     
     Método que inicializa as views do login. Ele recebe o controller da view.
     
     - parameter viewController: Um controlador do tipo LoginViewControllerProtocol.
     
     */
    init(controller: LoginViewControllerProtocol)
    
    /**
     
     Método que recebe dados do usuário para inserir uma nova conta no back-end.
     
     - parameter user: objeto que contém dados da conta (userIdentifier, fullName, email).
     
     */
    func addNewUser(_ user: ASAuthorizationAppleIDCredential)
    
    /**
     
     Método que recebe dados do usuário para verificar a existencia do mesmo no banco de dados
     
     - parameter user : objeto que contém dados da conta (user e password).
     
     */
    func checkUserExistence(_ user: ASPasswordCredential)
    
    // Dependências
    var myView: LoginViewProtocol? {get set}
}

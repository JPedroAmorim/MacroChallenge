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
     
     Método que recebe dados do usuário para inserir uma nova conta no back-end e no Userdefaults.
     
     - parameter user: objeto que contém dados da conta (userIdentifier).
     
     */
    func addNewUser(_ userIdentifier: String) 
    
    /**
     
     Método que recebe dados do usuário para verificar a existencia do mesmo no banco de dados
     
     - parameter user : objeto que contém dados da conta (userIdentifier).
     
     */
    func checkUserExistence(_ userIdentifier: String)
    
    // Dependências
    var myView: LoginViewProtocol? {get set}
}

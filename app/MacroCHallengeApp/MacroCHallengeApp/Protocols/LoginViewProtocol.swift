//
//  LoginViewProtocol.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/11/20.
//

import Foundation

protocol LoginViewProtocol {
    /**
     
     Método que inicializa as views do login. Ele recebe o controller da view.
     
     - parameter viewController: Um controlador do tipo LoginViewControllerProtocol.
     
     */
    init(controller: LoginViewControllerProtocol)
    
    // Dependências
    var viewController: LoginViewControllerProtocol {get set}
}

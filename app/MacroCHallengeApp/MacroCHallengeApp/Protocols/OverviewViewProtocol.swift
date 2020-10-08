//
//  OverviewViewProtocol.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import Foundation

protocol OverviewViewProtocol {
    /**
     
     Método que inicializa a view da visão geral da prova. Ele deve receber a prova que a view irá mostrar. Ele
     também recebe o controlador da view.
     
     
     - parameter data: A prova sendo realizada.
     - parameter controller: Um controlador do tipo OverviewControllerProtocol
     
     */
    
    init(data: Test, controller: OverviewViewControllerProtocol)
    
    // Dependências
    var viewController: OverviewViewControllerProtocol  {get set}
}

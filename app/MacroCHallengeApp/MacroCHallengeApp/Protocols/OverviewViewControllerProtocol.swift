//
//  OverviewViewControllerProtocol.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import Foundation

protocol OverviewViewControllerProtocol {
    /**
     
     Método que inicializa o controller para a visão geral da prova. Ele deve receber a prova para ser realizada.
     
     
     - parameter data: A prova que será realizada.
     
     */
    
    init(data: Test)
    
    // Dependências
    var myView: OverviewViewProtocol? {get set}
}

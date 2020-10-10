//
//  QuestionView.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import Foundation

protocol QuestionViewProtocol {
    /**
     
     Método que inicializa a view de uma questão específica. Ela deve receber a questão que a view irá mostrar. Ele
     também recebe o controlador da view.
     
     
     - parameter data: Uma única questão que será exibida.
     - parameter controller: Um controlador do tipo QuestionViewControllerProtocol.
     
     */
    
    init(data: Question, controller: QuestionViewControllerProtocol)
    
    /**
     
     Método que irá sobrescrever os elementos visuais da questão atual com a questão fornecida.
     
     - parameter data: A questão que agora será exibida.
     
     */
    
    func overwrite(data: Question)
    
    /**
     
     Método que irá sinalizar a view que a questão já foi respondida e ela deveria 
     - parameter data: A questão que agora será exibida.
     
     */
    
    // Dependências
    var controller: QuestionViewControllerProtocol  {get set}
}

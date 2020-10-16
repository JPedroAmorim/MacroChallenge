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
     - parameter wasAlreadyAnswered: String opcional para indicar se uma questão já foi ou não respondida. Caso seu valor não
     seja nil, quer dizer que a questão já foi respondida.
     - parameter shouldPresentAnswer: Booleano para indicar se a questão deveria mostrar a resposta.
     
     */
    
    func overwrite(data: Question, wasAlreadyAnswered: String?, shouldPresentAnswer: Bool)
    
    /**
     
     Método que irá sinalizar a view que a questão já foi respondida e ela deveria sinalizar a questão.
     
     - parameter data: A questão que agora será exibida.
     
     */
    // todo
    
    /**
     
     Método que irá sinalizar a view para atualizar a sua label do cronômetro.
     
     - parameter newTimeText: O novo texto do cronômetro no formato HH:MM (exemplo 01:20)
     
     */
    func updateTime(_ newTimeText: String)
    
    // Dependências
    var controller: QuestionViewControllerProtocol {get set}
}

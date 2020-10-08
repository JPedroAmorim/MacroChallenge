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
    
    /**
     
     Método pelo qual a view avisa o controller que uma questão foi selecionada.
     
     
     - parameter question: A questão selecionada.
     
     */
    
    func questionWasSubmitted(_ question: Question)
    
    /**
     
     Método pelo qual o controller é avisado que uma questão foi respondida. O OverviewController é o responsável por
     manter memória de quais questões foram respondidas.
     
     
     - parameter question: A questão selecionada.
     - parameter answer: A resposta fornecida pelo usuário.
     
     */
    
    func answerForQuestionWasSubmitted(question: Question, answer: String)
    
    // Dependências
    var myView: OverviewViewProtocol? {get set}
}

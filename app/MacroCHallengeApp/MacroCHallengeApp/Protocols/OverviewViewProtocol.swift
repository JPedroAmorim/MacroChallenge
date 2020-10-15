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
    
    /**
     
     Método que atualiza o progresso mostrado na barra de progresso no overview.
     
     
     - parameter percentage: O progresso a ser mostrado.
     
     */
    
    func updatePercentage(percentage: Double)
    
    /**
     
     Método que atualiza a label que contém o número de já questões feitas.
     
     
     - parameter questionsAnswered: Número de questões já feitas.
     
     */
    
    func updateCurrentQuestionsLabel(questionsAnswered: Int)
    
    /**
     
     Método que indica visualmente no overview as questões respondidas.
     
     
     - parameter questionsAnswered: Um vetor de inteiros com os números das questões já respondidas.
     
     */
    
    func updateAnsweredQuestions(questionsAnswered: [Int])
    
    // Dependências
    var viewController: OverviewViewControllerProtocol  {get set}


	/**

	Método que reorganiza os elementos para o modo landscape.


	- parameter questionsAnswered: Um vetor de inteiros com os números das questões já respondidas.

	*/
	func updateFrame()
}

//
//  QuestionViewController.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import Foundation

protocol QuestionViewControllerProtocol {
    /**

        Método que inicializa o controller para uma prova específica. Ele deve receber todas as questões da prova.


        -parameter data: As questões da prova.

    */
    init(data: [Question])

    /**

        Método que alerta o controller que o botão “próximo” foi pressionado. Este método deve conter a lógica para, a partir dele, a próxima questão ser exibida na view.

    */
    func nextWasSubmitted()

    /**

        Método que alerta o controller que o botão “anterior” foi pressionado. Este método deve conter a lógica para, a partir dele, a questão anterior ser exibida na view.

    */
    func previousWasSubmitted()

    // Dependências
    var myView: QuestionViewProtocol? {get set}
}

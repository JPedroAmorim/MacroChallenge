//
//  ResultsViewController.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 13/10/20.
//

import Foundation

protocol ResultsViewControllerProtocol {
    /**
     
     Método responsável por inicializar o controlador com os dados necessários para que ele realize os cálculos em cima
     dos resultados obtidos pelo usuário ao final de uma prova.
     
     - parameter Test: A prova realizada.
     - parameter answeredQuestions: As repostas fornecidas pelo usuário ao finalizar a prova.
     
     */
    init(test: Test, answeredQuestions: [String : String])
}

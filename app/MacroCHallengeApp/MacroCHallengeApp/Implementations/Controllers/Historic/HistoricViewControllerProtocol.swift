//
//  HistoricViewControllerProtocol.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import Foundation

protocol HistoricViewControllerProtocol {
	/**

	Método que recebe um objeto School da view e a partir dele, é responsável de chamar o próximo controller responsável por exibir dados de um colégio específico

	- parameter school: Escola selecionada pela View.

	*/
	func schoolWasSubmitted(_ school: School)
	func testWasSubmitted(_ test: Test)

	// Dependências
	var myView: HistoricViewProtocol? {get set}
	var schools: SchoolsProtocol? {get set}
}

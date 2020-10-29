//
//  HistoricViewController.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import UIKit

class HistoricViewControllerImplementation: UIViewController,  HistoricViewControllerProtocol {
	// MARK: - Dependencies
	/*

	Nota: como este View Controller é o primeiro a ser instanciado no Storyboard, ele é o único que possuirá
	dependências opcionais que não são a sua view. Para contornarmos isso, existem métodos de setup que são responsáveis
	por popular essas variáveis com suas implementações padrões. Para os demais controllers, as implementações padrões de
	suas dependências (exceto pela view) são passadas em seu inicializador (veja o método schoolWasSubmitted, por exemplo).
	*/

	var myView: HistoricViewProtocol?
	var schools: SchoolsProtocol?

	// MARK: - Lifecycle methods
	override func loadView() {
		super.loadView()
		setupDefaultSchoolsImplementation()
		setupDefaultViewImplementation()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Histórico"
	}

	// MARK: - Setup methods
	private func setupDefaultSchoolsImplementation() {
		self.schools = MockSchoolsImplementation()
	}

	private func setupDefaultViewImplementation() {
		if let data = schools?.getSchools() {
			let defaultView = HistoricViewImplementation(data: data, controller: self)
			self.myView = defaultView
			self.view = defaultView
		}
	}
	

	// MARK: - HistoricViewControllerProtocol methods

	func testWasSubmitted(_ test: Test) {
		if let navController = self.navigationController {
			let overviewViewController = OverviewViewControllerImplementation(data: test)
			navController.pushViewController(overviewViewController, animated: true)
		}
	}
}



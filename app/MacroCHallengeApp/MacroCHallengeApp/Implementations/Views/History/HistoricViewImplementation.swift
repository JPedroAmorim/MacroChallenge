//
//  HistoricViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import Foundation
import UIKit
import AuthenticationServices

class HistoricViewImplementation: UIView, HistoricViewProtocol {
	// MARK: -IBOutlets
	@IBOutlet weak var tableViewSchools: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
	// MARK: - Dependencies
	var viewController: HistoricViewControllerProtocol

	// MARK: - Private attributes
	private var data: [School]
	private var dataTableView: [School]

	// MARK: - Init methods
	required init(data: [School], controller: HistoricViewControllerProtocol) {
		self.data = data
		self.dataTableView = SchoolsServiceManager().getSchools()

		self.viewController = controller
		super.init(frame: CGRect.zero)
		initFromNib()

		setupDelegateTableview()
        self.activityIndicator.isHidden = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func initFromNib() {
		if let nib = Bundle.main.loadNibNamed("HistoricViewImplementation", owner: self, options: nil),
		   let nibView = nib.first as? UIView {
			nibView.frame = bounds
			nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			addSubview(nibView)
		}
	}
}

// MARK: - Extension Table View Data Source Methods
extension HistoricViewImplementation:UITableViewDataSource, UITableViewDelegate {

	func setupDelegateTableview() {
		tableViewSchools.delegate = self
		tableViewSchools.dataSource = self
		tableViewSchools.register(UINib(nibName: "SchoolsTableViewCell", bundle: nil), forCellReuseIdentifier: "SchoolsTableViewCell")
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return dataTableView.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return dataTableView[section].tests.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		var cellIdentifier = String()

		cellIdentifier = "TestTableViewCell"
		referenceXib(nibName: cellIdentifier)

		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TestTableViewCell  else {
			fatalError("The dequeued cell is not an instance of TestTableViewCell.")
		}

		let nameTitle = handleStringName(name: dataTableView[indexPath.section].tests[indexPath.row].name)
		cell.testLabel.text = nameTitle
        
		return cell
	}

	/**
		Função para tratamento da string de título, insere um espaço entre o nome da prova e o ano respectivo

		- parameter name: nome concatenado
	*/
	func handleStringName(name: String) -> String {
		var characters = Array(name)

		for i in 0...(characters.count - 1) {
			if Int(String(characters[i])) != nil {
				characters.insert(" ", at: i)
				break
			}
		}

        return String(characters).capitalizingFirstLetter()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableViewSchools.deselectRow(at: indexPath, animated: true)
		viewController.testWasSubmitted(data[indexPath.section].tests[indexPath.row])
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		return dataTableView[section].name
	}

	func referenceXib(nibName: String) {
		let nib = UINib.init(nibName: nibName, bundle: nil)
		self.tableViewSchools.register(nib, forCellReuseIdentifier: nibName)
	}

	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		(view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.init(red: 242/255,
																						  green: 242/255,
																						  blue: 247/255,
																						  alpha: 1.0)
		(view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.init(red: 123/255,
																				   green: 123/255,
																				   blue: 123/255,
																				   alpha: 1.0)
	}
}

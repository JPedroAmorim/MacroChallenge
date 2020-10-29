//
//  HistoricViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 27/10/20.
//

import Foundation

import UIKit

class HistoricViewImplementation: UIView, HistoricViewProtocol {
	// MARK: -IBOutlets
	//	@IBOutlet weak var tableViewSchools: UITableView!
	@IBOutlet weak var tableViewSchools: UITableView!
	
	// MARK: - Dependencies
	var viewController: HistoricViewControllerProtocol

	// MARK: - Private attributes
	private var data: [School]

	// MARK: - Init methods
	required init(data: [School], controller: HistoricViewControllerProtocol) {
		self.data = data
		self.viewController = controller
		super.init(frame: CGRect.zero)
		initFromNib()

		setupDelegateTableview()
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
		return 3
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		switch section {
			case 0:
				return data[0].tests.count
			case 1:
				return data[1].tests.count

			default:
				return data[2].tests.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		var cellIdentifier = String()

		cellIdentifier = "TestTableViewCell"
		referenceXib(nibName: cellIdentifier)

		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TestTableViewCell  else {
			fatalError("The dequeued cell is not an instance of TestTableViewCell.")
		}

		cell.testLabel.text = data[indexPath.section].tests[indexPath.row].name

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableViewSchools.deselectRow(at: indexPath, animated: true)
		viewController.testWasSubmitted(data[indexPath.section].tests[indexPath.row])

//		ResultsViewController(test: data, answeredQuestions: questionsAnswered, timeElapsed: "00:00", questionController: questionController)
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		let sectionName: String
		switch section {
			case 0:
				sectionName = "Colégio Técnico Industrial"
			case 1:
				sectionName = "Cotuca"

			case 2:
				sectionName = "Etec"

			default:
				sectionName = ""
		}
		return sectionName
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

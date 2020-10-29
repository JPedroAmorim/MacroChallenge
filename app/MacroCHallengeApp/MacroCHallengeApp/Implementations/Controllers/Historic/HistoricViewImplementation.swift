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
				return data.count
			case 1:
				return data.count
			// ...
			default:
				return data.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolsTableViewCell", for: indexPath) as? SchoolsTableViewCell {
			cell.schoolLabel.text = data[indexPath.row].name
			cell.locationLabel.text = data[indexPath.row].location.joined(separator: " ")
			cell.logoImageView.image = data[indexPath.row].logo
			return cell
		} else {
			let cell = UITableViewCell.init()
			cell.textLabel?.text = data[indexPath.row].name
			return cell
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableViewSchools.deselectRow(at: indexPath, animated: true)
//		viewController.schoolWasSubmitted(data[indexPath.row])
		viewController.testWasSubmitted(data[indexPath.row].tests.first!)
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

	private func tableView (tableView:UITableView , heightForHeaderInSection section:Int)->Float
	{

		let title = self.tableView(tableView, titleForHeaderInSection: section)
		if (title == "") {
			return 0.0
		}
		return 20.0
	}
}

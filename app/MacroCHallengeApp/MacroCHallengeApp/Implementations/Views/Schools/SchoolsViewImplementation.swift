//
//  SchoolsViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolsViewImplementation: UIView, SchoolsViewProtocol {
	// MARK: -IBOutlets
	@IBOutlet var testLabel: UILabel!
	@IBOutlet weak var tableViewSchools: UITableView!

	// MARK: - Dependencies
	var viewController: SchoolsViewControllerProtocol

	// MARK: - Private attributes
	private var data: [School]

	// MARK: - Init methods
	required init(data: [School], controller: SchoolsViewControllerProtocol) {
		self.data = data
		self.viewController = controller
		super.init(frame: CGRect.zero)
		initFromNib()
		setVisualElements()

		dataTableview()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func initFromNib() {
		if let nib = Bundle.main.loadNibNamed("SchoolsViewImplementation", owner: self, options: nil),
		   let nibView = nib.first as? UIView {
			nibView.frame = bounds
			nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			addSubview(nibView)
		}
	}

	// MARK: - Private methods

	/**
	Método responsável, a partir da propriedade self.data, popular os elementos visuais da view.
	*/
	private func setVisualElements() {
		// TODO: Realmente popular. O código abaixo é um exemplo.
		if let firstSchool = data.first {
			testLabel.text = firstSchool.name
		}
	}

	@IBAction func testButtonPressed(_ sender: Any) {
		if let firstSchool = data.first {
			viewController.schoolWasSubmitted(firstSchool)
		}
	}
}

// MARK: - Extension Table View Data Source Methods

extension SchoolsViewImplementation:UITableViewDataSource, UITableViewDelegate {

	func dataTableview() {

		tableViewSchools.delegate = self
		tableViewSchools.dataSource = self

//		guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
//			return
//		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = UITableViewCell.init()
		cell.textLabel?.text = "asdasd"
		cell.detailTextLabel?.text = "222"

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
}

//
//  AnswersCollection.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 16/10/20.
//

import UIKit

class AnswersCollectionView: UITableViewCell {

	// MARK: -IBOutlets

	// MARK: - Private attributes

	// MARK: -Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	// MARK: - Public Methods

	func updateView(topic: String, numberOfRightAnswers: Int, totalNumberOfQuestions: Int, percetage: Double){

	}

	// MARK: - Private Methods

	/**

	Método responsável por acrescentar corner radius em uma view.

	- parameters view: view no qual será acrescentado corner radius.

	*/

	private func settingCornerRadiusOnView(view: UIView) {
		view.layer.cornerRadius = 8
	}
}

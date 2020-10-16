//
//  AnswersCollection.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 16/10/20.
//

import UIKit

class AnswersCollectionView: UITableViewCell {

	// MARK: -IBOutlets
	@IBOutlet weak var topicLabel: UILabel!
	@IBOutlet weak var finalGradeLabel: UILabel!
	@IBOutlet weak var barView: UIView!
	@IBOutlet weak var progressView: UIView!
	@IBOutlet weak var bgView: UIView!

	// MARK: - Private attributes
	private var topic = String()
	private var numberOfRightAnswers: Int = 0
	private var totalNumberOfQuestions: Int = 0
	private var percentage: Double = 0.0
	@IBOutlet weak var questionsCollection: UICollectionView!

	// MARK: -Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	// MARK: - Public Methods

	func updateView(){

		print("updateView")

		setupDelegateCollectionview()

	}

}

// MARK: - Extension Table View Data Source Methods
extension AnswersCollectionView:UICollectionViewDataSource, UICollectionViewDelegate {

	func setupDelegateCollectionview() {
		questionsCollection.delegate = self
		questionsCollection.dataSource = self
		questionsCollection.register(UINib(nibName: "OverviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "OverviewCollectionCell")
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = questionsCollection.dequeueReusableCell(withReuseIdentifier: "OverviewCollectionCell", for: indexPath) as! OverviewCollectionCell
		cell.numberLabel.text = "1"

		cell.bgView.backgroundColor = UIColor.white
		cell.numberLabel.textColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1)

		return cell
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath.row)
	}
}

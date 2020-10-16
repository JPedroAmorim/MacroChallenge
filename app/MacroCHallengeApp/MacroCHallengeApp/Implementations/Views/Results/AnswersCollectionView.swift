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

		let view = UIView()
		view.backgroundColor = .white

		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
		layout.itemSize = CGSize(width: 60, height: 60)
		
		questionsCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
		questionsCollection?.backgroundColor = UIColor.black

		questionsCollection?.dataSource = self
		questionsCollection?.delegate = self

	}

}

extension AnswersCollectionView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 9 // How many cells to display
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
		myCell.backgroundColor = UIColor.blue
		return myCell
	}
}

extension AnswersCollectionView: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("User tapped on item \(indexPath.row)")
	}
}

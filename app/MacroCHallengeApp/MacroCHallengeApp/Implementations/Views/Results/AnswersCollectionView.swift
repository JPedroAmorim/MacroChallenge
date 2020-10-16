//
//  AnswersCollection.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 16/10/20.
//

import UIKit

class AnswersCollectionView: UITableViewCell {

	// MARK: -IBOutlets
	@IBOutlet weak var bgView: UIView!
	@IBOutlet weak var questionsCollection: UICollectionView!

	// MARK: - Private attributes
	private var data: ResultsData!

	// MARK: -Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	// MARK: - Public Methods
	func updateView(data: ResultsData){
		print("data")
		print(data.correctAnswers)
		setupDelegateCollectionview()
		setupLayout()
	}

	//MARK: - Private Methods
	fileprivate func setupLayout() {
		let height = questionsCollection.collectionViewLayout.collectionViewContentSize.height

		let heightConstraint = NSLayoutConstraint(item: bgView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
		NSLayoutConstraint.activate([heightConstraint])
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
		100
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

//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {

	var answeredQuestionsArray = [Int]()

	// MARK: -IBOutlets
	@IBOutlet weak var questionsView: UIView!
	@IBOutlet weak var questionsCollege: UICollectionView!

	@IBOutlet weak var progressLabel: UILabel!
	@IBOutlet weak var progressBar: UIView!

	// MARK: - Dependencies
	var viewController: OverviewViewControllerProtocol

	// MARK: - Private attributes
	private var data: Test

	// MARK: - Init methods
	required init(data: Test, controller: OverviewViewControllerProtocol) {
		self.data = data
		self.viewController = controller
		super.init(frame: CGRect.zero)
		initFromNib()

		// To Do: novo parametro da classe para progresso atual
		setupVisualElements()
		setupDelegateCollectionview()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func initFromNib() {
		if let nib = Bundle.main.loadNibNamed("OverviewViewImplementation", owner: self, options: nil),
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

	private func setupVisualElements() {
		questionsView.layer.cornerRadius = 8
		progressBar.layer.cornerRadius = 16
		updatePercentage(percentage: 0.0)
	}

	func updatePercentage(percentage: Double) {
		let currentProgress = UIView()
		currentProgress.backgroundColor = UIColor(named: "PrimaryGraphicsColor")
		currentProgress.frame = CGRect(x: 0, y: 0, width: progressBar.frame.width*CGFloat(percentage)*0.01, height: progressBar.frame.height)
		currentProgress.layer.cornerRadius = 16
		progressBar.addSubview(currentProgress)

		progressLabel.text = String(format: "%02d",
									Int(Double(data.questions.count)*Double(CGFloat(percentage))*0.01)) +
									"/" + String(format: "%02d", data.questions.count)
	}

	func updateAnsweredQuestions(questionsAnswered: [Int]) {
		print("updateAnsweredQuestions")
		answeredQuestionsArray = questionsAnswered
		questionsCollege.reloadData()
	}
}

// MARK: - Extension Table View Data Source Methods
extension OverviewViewImplementation:UICollectionViewDataSource, UICollectionViewDelegate {

	func setupDelegateCollectionview() {
		questionsCollege.delegate = self
		questionsCollege.dataSource = self
		questionsCollege.register(UINib(nibName: "OverviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "OverviewCollectionCell")
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		data.questions.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = questionsCollege.dequeueReusableCell(withReuseIdentifier: "OverviewCollectionCell", for: indexPath) as! OverviewCollectionCell
		cell.numberLabel.text = data.questions[indexPath.row].number

		if answeredQuestionsArray.contains(Int(data.questions[indexPath.row].number)!) {
			cell.bgView.backgroundColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha: 1)
			cell.numberLabel.textColor = UIColor.white
		}

		return cell
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewController.questionWasSubmitted(data.questions[indexPath.row])
	}
}

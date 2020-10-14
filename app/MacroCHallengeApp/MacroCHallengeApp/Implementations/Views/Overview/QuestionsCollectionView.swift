//
//  QuestionsCollectionView.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 14/10/20.
//

import UIKit

class QuestionsCollectionView: UIView, OverviewViewProtocol {
	// MARK: - Constants
	// TODO: Ver como essa view de fato obterá essa informação
	let testDurationInSeconds = 2 * 60 // Valor de teste: Dois minutos

	// MARK: - Variables
	private var answeredQuestionsArray = [Int]()
	private var simulatorStarted = false
	private var customView = HorizontalChartView(title: "Progresso", correctQuestions: 0, totalQuestions: 0, percentage: 0)

	// MARK: -IBOutlets
	@IBOutlet weak var questionsCollege: UICollectionView!

	// MARK: - Dependencies
	var viewController: OverviewViewControllerProtocol

	// MARK: - Alerts
	func showAlert(title: String, msg: String, shouldPresentCancel: Bool, closure: @escaping (UIAlertAction) -> Void) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

		if shouldPresentCancel {
			alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
		}

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: closure))

		if let viewController = self.viewController as? UIViewController {
			viewController.present(alert, animated: true, completion: nil)
		}

	}

	func showAlertStartSimulator(title: String, msg: String) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

		alert.addAction(UIAlertAction(title: "OK", style: .default))

		if let viewController = self.viewController as? UIViewController {
			viewController.present(alert, animated: true, completion: nil)
		}
	}

	// MARK: - Private attributes
	private var data: Test

	// MARK: - Init methods
	required init(data: Test, controller: OverviewViewControllerProtocol) {
		self.data = data
		self.viewController = controller
		super.init(frame: CGRect.zero)
		initFromNib()

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

		updatePercentage(percentage: 0.0)
		updateCurrentQuestionsLabel(questionsAnswered: 0)

	}

	/**

	Método responsável por gerir o tempo dedicado à uma prova. Ele é responsável por atualizar os elementos gráficos ligados ao tempo. Quando o tempo da prova acaba (definido pela constante
	testDurationInSeconds) é emitido um aviso sobre o ocorrido e o timer é invalidado.

	*/

	// MARK: - OverviewViewProtocol methods
	func updatePercentage(percentage: Double) {
		customView.updatePercentage(percentage: percentage)
	}

	func updateCurrentQuestionsLabel(questionsAnswered: Int) {
		customView.updateCurrentQuestionsLabel(questionsAnswered: questionsAnswered, totalQuestions: data.questions.count)
	}

	func updateAnsweredQuestions(questionsAnswered: [Int]) {
		answeredQuestionsArray = questionsAnswered
		questionsCollege.reloadData()
	}
}

// MARK: - Extension Table View Data Source Methods
extension QuestionsCollectionView:UICollectionViewDataSource, UICollectionViewDelegate {

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

		if let questionNumber = Int(data.questions[indexPath.row].number) {
			if answeredQuestionsArray.contains(questionNumber) {
				cell.bgView.backgroundColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1)
				cell.bgView.layer.borderColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1).cgColor
				cell.numberLabel.textColor = UIColor.white
			} else {
				cell.bgView.backgroundColor = UIColor.white
				cell.numberLabel.textColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha: 1)
			}
		}

		return cell
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if simulatorStarted {
			viewController.questionWasSubmitted(data.questions[indexPath.row])
		} else {
			showAlertStartSimulator(title: "Inicie o simulado", msg: "É necessário iniciar o simulado para ver a questão")
		}
	}
}

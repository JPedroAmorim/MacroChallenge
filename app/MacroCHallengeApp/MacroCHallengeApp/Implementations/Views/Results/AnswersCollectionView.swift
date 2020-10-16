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
	private var viewController: ResultsViewControllerProtocol!

	private var sectionDictionary: [String:(Int, Int)] = [:]
	private var answeredQuestionsArray = [Int]()

	// MARK: -Lifecycle

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	// MARK: - Public Methods
	func updateView(data: ResultsData, viewController: ResultsViewControllerProtocol){

		self.viewController = viewController
		self.data = data

		setupSectionDictionary()
		setupDelegateCollectionview()
		setupLayout()
	}

	//MARK: - Private Methods
	fileprivate func setupLayout() {

		if let backgroundView = bgView {
			let height = questionsCollection.collectionViewLayout.collectionViewContentSize.height

			let heightConstraint = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
			NSLayoutConstraint.activate([heightConstraint])
		}
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
		var numberOfItemsInSection = 0
		let dictionaryKeysAsArray = Array(sectionDictionary.keys)

		for index in 0...(dictionaryKeysAsArray.count - 1) {
			let key = dictionaryKeysAsArray[index]
			guard let tupleValue = sectionDictionary[key] else {
				return 0
			}

			if tupleValue.0 == section{
				numberOfItemsInSection = tupleValue.1
			}
		}

		return numberOfItemsInSection
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = questionsCollection.dequeueReusableCell(withReuseIdentifier: "OverviewCollectionCell", for: indexPath) as! OverviewCollectionCell
		let indexFix = giveCorrectQuestionNumberForIndexPath(section: indexPath.section)
		cell.numberLabel.text = data.test.questions[indexFix + indexPath.row].number

		if let questionNumber = Int(data.test.questions[indexFix + indexPath.row].number) {
			if data.correctAnswers.contains(questionNumber) {
				cell.bgView.backgroundColor = UIColor(red:14/255, green:173/255, blue:0/255, alpha: 1)
				cell.bgView.layer.borderColor = UIColor(red:14/255, green:173/255, blue:0/255, alpha: 1).cgColor
				cell.numberLabel.textColor = UIColor.white
				cell.stateImage.isHidden = false
			} else {
				cell.bgView.backgroundColor = UIColor(red:255/255, green:90/255, blue:90/255, alpha: 1)
				cell.bgView.layer.borderColor = UIColor(red:255/255, green:90/255, blue:90/255, alpha: 1).cgColor
				cell.numberLabel.textColor = UIColor.white
				cell.stateImage.image = UIImage(named: "wrong")
				cell.stateImage.isHidden = false
			}
		}

		return cell
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return sectionDictionary.count
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("\(indexPath) selected")

		let indexFix = giveCorrectQuestionNumberForIndexPath(section: indexPath.section)
		viewController.questionWasSubmitted(data.test.questions[indexFix + indexPath.row])
	}

	/**

	Método que retorna o número da questão dentro de uma seção para que a OverView tenha questões do 1, 2,..., {número total de questões da prova}.

	*/

	private func giveCorrectQuestionNumberForIndexPath(section: Int) -> Int{
		var jumpAmount: Int = 0

		for (_, value) in sectionDictionary {
			if value.0 < section {
				jumpAmount += value.1
			}
		}

		return jumpAmount
	}

	/**

	Método que monta o dicionário de seções, onde a chave é a seção e o valor é uma tupla. O primeiro valor da tupla é o número da seção que ela representa na Collection View e o segundo valor da tupla representa o número de questões dentro dessa seção.

	*/

	private func setupSectionDictionary() {
		let dictionaryKeys: [String] = setupSectionDictionaryKeys()
		var index = 0

		for key in dictionaryKeys {
			sectionDictionary[key] = (index , countingQuestionsForTopic(key))
			index += 1
		}
	}

	/**

	Método que nos retorna o número de questões de um determinado tópico.

	- parameter topic: Tópico de uma prova.

	*/

	private func countingQuestionsForTopic(_ topic: String) -> Int {
		var result: Int = 0

		for question in data.test.questions {
			if question.topic == topic {
				result += 1
			}
		}

		return result
	}

	/**

	Método responsável de montar o array de seções a partir das questões da prova.

	*/

	private func setupSectionDictionaryKeys() -> [String]{
		var resultSet: Set<String> = Set<String>()

		for question in data.test.questions {
			resultSet.insert(question.topic)
		}

		return Array(resultSet)
	}
}

//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {
    // MARK: - Variables
    private var answeredQuestionsArray = [Int]()
    private var simulatorStarted = false
    private var customView = HorizontalChartView(title: "Progresso", correctQuestions: 0, totalQuestions: 0, percentage: 0)
    
    // MARK: -IBOutlets
    @IBOutlet weak var questionsView: UIView!
    @IBOutlet weak var questionsCollege: UICollectionView!
    @IBOutlet weak var startSimulatorButton: UIButton!
    @IBOutlet var clockLabel: UILabel!
    
    @IBOutlet weak var progressChart: UIView!
    
    // MARK: - IBActions
    @IBAction func startSimulatorButton(_ sender: Any) {
        if simulatorStarted {
            showAlert(title: "Deseja finalizar simulado?", msg: "Sua prova será finalizada e a nota calculada", shouldPresentCancel: true, closure: ({ action in
                self.viewController.hasEnded()
                self.simulatorStarted = false
                self.startSimulatorButton.setTitle("Iniciar Simulado", for: .normal)
            }))
        } else {
            viewController.hasBegun()
            simulatorStarted = true
            startSimulatorButton.setTitle("Finalizar Simulado", for: .normal)
        }
    }
    
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
        
        customView.frame = self.progressChart.bounds
        self.progressChart.addSubview(customView)
        updatePercentage(percentage: 0.0)
        updateCurrentQuestionsLabel(questionsAnswered: 0)
        
        startSimulatorButton.layer.cornerRadius = 8
        startSimulatorButton.layer.borderWidth = 3
        startSimulatorButton.layer.borderColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1).cgColor
        startSimulatorButton.titleLabel?.tintColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1)
    }
    
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
    
    func updateTime(_ newTimeText: String) {
        self.clockLabel.text = newTimeText
    }
    
    func showTimeHasEndedAlert() {
        showAlert(title: "O tempo para o simulado acabou", msg: "O tempo dedicado à prova acabou. Mesmo assim, você ainda pode finalizar as suas questões.", shouldPresentCancel: false, closure: ({action in}))
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

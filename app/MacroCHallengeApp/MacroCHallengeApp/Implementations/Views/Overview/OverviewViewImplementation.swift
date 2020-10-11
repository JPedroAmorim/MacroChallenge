//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {
    // MARK: - Constants
    // TODO: Ver como essa view de fato obterá essa informação
    let testDurationInSeconds = 2 * 60 // Valor de teste: Dois minutos
    
    // MARK: - Variables
    var answeredQuestionsArray = [Int]()
    var simulatorStarted = false
    
    // MARK: -IBOutlets
    @IBOutlet weak var questionsView: UIView!
    @IBOutlet weak var questionsCollege: UICollectionView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var startSimulatorButton: UIButton!
    @IBOutlet var clockLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func startSimulatorButton(_ sender: Any) {
        if simulatorStarted {
            showAlert(title: "Deseja finalizar simulado?", msg: "Sua prova será finalizada e a nota calculada", closure: ({ action in
                self.viewController.hasEnded()
                self.simulatorStarted = false
                self.startSimulatorButton.setTitle("Iniciar Simulado", for: .normal)
            }))
        } else {
            setClock()
            simulatorStarted = true
            startSimulatorButton.setTitle("Finalizar Simulado", for: .normal)
        }
    }
    
    // MARK: - Dependencies
    var viewController: OverviewViewControllerProtocol
    
    // MARK: - Alerts
    func showAlert(title: String, msg: String, closure: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
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
        progressLabel.text = "00" + "/" + String(format: "%02d", data.questions.count)
        questionsView.layer.cornerRadius = 8
        progressBar.layer.cornerRadius = 16
        
        startSimulatorButton.layer.cornerRadius = 8
        startSimulatorButton.layer.borderWidth = 3
        startSimulatorButton.layer.borderColor = UIColor.systemBlue.cgColor
        updatePercentage(percentage: 0.0)
    }
    
    /**
     
     Método responsável por gerir o tempo dedicado à uma prova. Ele é responsável por atualizar os elementos gráficos ligados ao tempo. Quando o tempo da prova acaba (definido pela constante
     testDurationInSeconds) é emitido um aviso sobre o ocorrido e o timer é invalidado.
     
     */
    private func setClock() {
        var totalCounter = 0
        var minuteCounter = 0
        var minutes = 0
        var hours = 0
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            totalCounter += 1
            minuteCounter += 1
            
            if minuteCounter == 60 {
                minutes += 1
                minuteCounter = 0
                
                if minutes == 60 {
                    hours += 1
                    minutes = 0
                }
                
                if minutes < 10 {
                    DispatchQueue.main.async {
                        self.clockLabel.text = String(format: "0%d", hours) + ":" + String(format: "0%d", minutes)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.clockLabel.text = String(format: "0%d", hours) + ":" + String(format: "0%d", minutes)
                    }
                }
            }
            
            if totalCounter == self.testDurationInSeconds {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.showAlert(title: "O tempo para o simulado acabou", msg: "O tempo dedicado à prova acabou. Mesmo assim, você ainda pode finalizar as suas questões", closure: ({action in}))
                }
            }
        }
    }
    
    // MARK: - OverviewViewProtocol methods
    func updatePercentage(percentage: Double) {
        let currentProgress = UIView()
        for view in progressBar.subviews { // Limpa subviews anteriores
            view.removeFromSuperview()
        }
        currentProgress.backgroundColor = UIColor(named: "PrimaryGraphicsColor")
        currentProgress.frame = CGRect(x: 0, y: 0, width: progressBar.frame.width*CGFloat(percentage)*0.01, height: progressBar.frame.height)
        currentProgress.layer.cornerRadius = 16
        progressBar.addSubview(currentProgress)
    }
    
    func updateCurrentQuestionsLabel(questionsAnswered: Int) {
        progressLabel.text = String(format: "%02d", questionsAnswered) + "/" + String(format: "%02d", data.questions.count)
    }
    
    func updateAnsweredQuestions(questionsAnswered: [Int]) {
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
        
        if let questionNumber = Int(data.questions[indexPath.row].number) {
            if answeredQuestionsArray.contains(questionNumber) {
                cell.bgView.backgroundColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha: 1)
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

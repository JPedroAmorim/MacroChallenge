//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {
    // MARK: - Private attributes
    private var data: Test
    private var answeredQuestionsArray = [Int]()
    private var simulatorStarted = false
    private var customView = HorizontalChartView(title: "Progresso", correctQuestions: 0, totalQuestions: 0, percentage: 0)
    
    // MARK: -IBOutlets
    @IBOutlet weak var questionsView: UIView!
    @IBOutlet weak var questionsCollege: UICollectionView!
    @IBOutlet var clockLabel: UILabel!
    @IBOutlet weak var progressChart: UIView!
    
    // MARK: - Dependencies
    var viewController: OverviewViewControllerProtocol
    
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
    
    func updateFrame() {
        customView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: progressChart.frame.width, height: 77))
    }
    // MARK: - Private methods
    
    /**
     
     Método que apresenta alertas na view.
     
     - parameter title: Título do alerta
     - parameter msg: Mensagem do alerta
     - parameter shouldPresentCancel: Booleano que indica se o alarme deve mostrar o botão "cancelar"'
     - parameter closure: Função executada ao ser pressionada a opção "ok"
     
     */
    private func showAlert(title: String, msg: String, shouldPresentCancel: Bool, closure: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        if shouldPresentCancel {
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: closure))
        
        if let viewController = self.viewController as? UIViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /**
     
     Método responsável, a partir da propriedade self.data, popular os elementos visuais da view.
     
     */
    private func setupVisualElements() {
        if let viewController = self.viewController as? UIViewController {
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Iniciar Prova", style: .plain, target: self, action: #selector(StartOrFinishNavButtonTapped))
        }
        
        customView = HorizontalChartView(title: "Progresso", correctQuestions: 0, totalQuestions: 0, percentage: 0)
        customView.frame = self.progressChart.bounds
        
        self.progressChart.addSubview(customView)
        
        customView.center = CGPoint(x: progressChart.frame.size.width  / 2,
                                    y: progressChart.frame.size.height / 2)
        
        updatePercentage(percentage: 0.0)
        updateCurrentQuestionsLabel(questionsAnswered: 0)
    }
    
    /**
     
     Função executada quando o botão de começar/finalizar o simulado é pressionado.
     
     */
    @objc private func StartOrFinishNavButtonTapped() {
        if simulatorStarted {
            showAlert(title: "Deseja finalizar simulado?", msg: "Sua prova será finalizada e a nota calculada", shouldPresentCancel: true, closure: ({ action in
                self.simulatorStarted = false
                self.viewController.hasEnded()
            }))
        } else {
            self.simulatorStarted = true
            self.viewController.hasBegun()
            self.viewController.questionWasSubmitted(data.questions[0])
        }
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
                cell.numberLabel.textColor = UIColor(red:25/255, green:95/255, blue:230/255, alpha: 1)
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
            self.showAlert(title: "Iniciar novo simulado?", msg: "Para acessar as questões comece um novo simulado", shouldPresentCancel: true, closure: ({ action in
                self.viewController.hasBegun()
                self.simulatorStarted = true
                self.viewController.hasBegun()
                self.viewController.questionWasSubmitted(self.data.questions[indexPath.row])
            }))
        }
    }
}

//
//  ProgressBarTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 14/10/20.
//

import UIKit

class ProgressBarTableViewCell: UITableViewCell {
    
    // MARK: -IBOutlets
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var finalGradeLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var progressView: UIView!
    
    // MARK: - Private attributes
    private var topic = String()
    private var numberOfRightAnswers: Int = 0
    private var totalNumberOfQuestions: Int = 0
    private var percentage: Double = 0.0
    
    // MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    
    func updateView(topic: String, numberOfRightAnswers: Int, totalNumberOfQuestions: Int, percetage: Double){
        self.topic = topic
        self.numberOfRightAnswers = numberOfRightAnswers
        self.totalNumberOfQuestions = totalNumberOfQuestions
        self.percentage = percetage
        
        settingCornerRadiusOnView(view: barView)
        settingCornerRadiusOnView(view: progressView)
        
        settingProgress(view: progressView)
        
        settingTextLabels()
    }
    
    // MARK: - Private Methods
    
    /**
     
     Método responsável por acrescentar corner radius em uma view.
     
     - parameters view: view no qual será acrescentado corner radius.
     
     */
    
    private func settingCornerRadiusOnView(view: UIView) {
        view.layer.cornerRadius = 8
    }
    
    /**
     
     Método responsável por colocar porcetagem na barra de progresso.
     
     */
    
    private func settingProgress(view: UIView) {
        
        let currentProgress = UIView()
        for view in barView.subviews { // Limpa subviews anteriores
            view.removeFromSuperview()
        }
        currentProgress.backgroundColor = UIColor(named: "PrimaryGraphicsColor")
        
        
        currentProgress.frame = CGRect(x: 0,
                                       y: 0,
                                       width: barView.frame.width * CGFloat(percentage) * 0.01,
                                       height: barView.frame.height)
        
        settingCornerRadiusOnView(view: currentProgress)
        barView.addSubview(currentProgress)
    }
    
    /**
     
     Método responsável por mudar o texto das labels.
     
     */
    
    private func settingTextLabels() {
        topicLabel.text = topic
        finalGradeLabel.text = "\(numberOfRightAnswers)/\(totalNumberOfQuestions)"
    }
}

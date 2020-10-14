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
    private var percetage: Double = 0.0
    
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
        self.percetage = percetage
        
        
    }
    
    // MARK: - Private Methods
    
    
}

//
//  QuestionButtonsTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 09/10/20.
//

import UIKit

class QuestionButtonsTableViewCell: UITableViewCell {

    var controller: QuestionViewControllerProtocol?
    
    // MARK: - Outlets
    @IBAction func submitPrevious(_ sender: Any) {
        controller?.previousWasSubmitted()
    }
    
    @IBAction func submitNext(_ sender: Any) {
        controller?.nextWasSubmitted()
    }
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

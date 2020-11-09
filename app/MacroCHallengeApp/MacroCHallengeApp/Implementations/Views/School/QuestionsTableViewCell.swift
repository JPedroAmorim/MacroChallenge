//
//  QuestionsTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 06/11/20.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTopic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingShadowAndCornerRadiusOnView(view: cardView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func settingShadowAndCornerRadiusOnView(view: UIView) {
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
    }
    
}

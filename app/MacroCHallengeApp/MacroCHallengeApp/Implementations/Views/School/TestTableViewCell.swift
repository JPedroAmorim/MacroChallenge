//
//  TestTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/10/20.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    // MARK: -IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var testLabel: UILabel!
    
    // MARK: -Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup card view
        self.cardView.layer.cornerRadius = 6
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowOpacity = 0.25
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.cardView.layer.shadowRadius = 1
        self.cardView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

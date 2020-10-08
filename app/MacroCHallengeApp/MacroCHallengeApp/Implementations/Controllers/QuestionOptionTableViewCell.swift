//
//  QuestionOptionTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 08/10/20.
//

import UIKit

class QuestionOptionTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lblIndex: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var CardView: UIView!
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
    }
    
    // MARK: - Private methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
    }
    
    /**
     Método responsável por definir qualidades visuais (sombra, corner radius) da célula.
     */
    private func setupCardView() {
        self.CardView.layer.cornerRadius = 6
        self.CardView.backgroundColor = .white
    }
}

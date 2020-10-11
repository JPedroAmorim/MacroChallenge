//
//  SchoolsTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 07/10/20.
//

import UIKit

class OverviewCollectionCell: UICollectionViewCell {
	// MARK: -IBOutlets
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var bgView: UIView!

	// MARK: -Lifecyle
	override func awakeFromNib() {
		super.awakeFromNib()
		setupCardView()
	}

	// MARK: - Private methods
	/**
     
     Método responsável por definir qualidades visuais (sombra, corner radius) da célula.
     
	*/
	private func setupCardView() {
		bgView.layer.borderWidth = 6
		bgView.layer.borderColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha: 1).cgColor
		bgView.layer.cornerRadius = 10
	}
}

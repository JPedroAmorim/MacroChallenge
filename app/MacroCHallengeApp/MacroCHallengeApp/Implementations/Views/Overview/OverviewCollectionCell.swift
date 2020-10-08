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

//	override func setSelected(_ selected: Bool, animated: Bool) {
//		super.setSelected(selected, animated: animated)
//	}

	// MARK: - Private methods
	/**

	Método responsável por definir qualidades visuais (sombra, corner radius) da célula.

	*/

	private func setupCardView() {
//		self.bgView.layer.cornerRadius = 6
//		self.bgView.layer.shadowColor = UIColor.black.cgColor
//		self.bgView.layer.shadowOpacity = 0.25
//		self.bgView.layer.shadowOffset = CGSize(width: 0, height: 4)
//		self.bgView.layer.shadowRadius = 1
//		self.bgView.layer.masksToBounds = false

		print("passandoo")
		bgView.layer.borderWidth = 6
		bgView.layer.borderColor = UIColor(red:200/255, green:200/255, blue:200/255, alpha: 1).cgColor

//			CGColor.init(red: 200, green: 200, blue: 200, alpha: 1)
		bgView.layer.cornerRadius = 10
	}
}

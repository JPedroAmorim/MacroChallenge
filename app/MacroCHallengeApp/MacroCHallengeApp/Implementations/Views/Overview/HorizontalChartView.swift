//
//  HorizontalChartView.swift
//  MacroCHallengeApp
//
//  Created by Joao Flores on 13/10/20.
//

import UIKit

class HorizontalChartView: UIView {
	// MARK: -IBOutlets
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var performanceLabel: UILabel!
	@IBOutlet weak var performanceBarView: UIView!

	// MARK: - Métodos de init
	init(title: String, correctQuestions: Double, totalQuestions: Double) {
		super.init(frame: CGRect.zero)

		initFromNib()

		self.titleLabel.text = title
		self.performanceLabel.text = String(Int(correctQuestions)) + "/" + String(totalQuestions)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func initFromNib() {
		if let nib = Bundle.main.loadNibNamed("HorizontalChartView", owner: self, options: nil),
		   let nibView = nib.first as? UIView {
			nibView.frame = bounds
			nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			addSubview(nibView)
		}
	}

	// MARK: - Private methods
	/**

	Método responsável por definir qualidades visuais (sombra, corner radius) da célula.

	*/

}

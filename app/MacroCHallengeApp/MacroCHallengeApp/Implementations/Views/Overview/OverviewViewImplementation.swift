//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {
	// MARK: -IBOutlets
	@IBOutlet weak var questionsView: UIView!
	@IBOutlet weak var questionsCollege: UICollectionView!

	@IBOutlet weak var progressLabel: UILabel!
	@IBOutlet weak var progressBar: UIView!

    // MARK: - Dependencies
    var viewController: OverviewViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: Test
    
    // MARK: - Init methods
    required init(data: Test, controller: OverviewViewControllerProtocol) {
        self.data = data
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib()
		setVisualElements()
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

	// MARK: - Private methods

	/**
	Método responsável, a partir da propriedade self.data, popular os elementos visuais da view.
	*/

	private func setVisualElements() {
		questionsView.layer.cornerRadius = 8

		progressBar.layer.cornerRadius = 16

		let image = UIView()
		image.tintColor = UIColor.red
		image.backgroundColor = UIColor(named: "PrimaryGraphicsColor")
		image.frame = CGRect(x: 0, y: 0, width: progressBar.frame.width/2, height: progressBar.frame.height)
		image.layer.cornerRadius = 16
		progressBar.addSubview(image)
	}
}

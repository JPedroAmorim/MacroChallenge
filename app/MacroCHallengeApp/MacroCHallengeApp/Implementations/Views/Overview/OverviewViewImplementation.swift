//
//  OverviewViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewImplementation: UIView, OverviewViewProtocol {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("SchoolViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
}

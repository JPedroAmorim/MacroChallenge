//
//  ResultsViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 13/10/20.
//

import UIKit

class ResultsViewImplementation: UIView, ResultsViewProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Dependencies
    var viewController: ResultsViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: ResultsData
    
    // MARK: - Init methods
    required init(data: ResultsData, viewController: ResultsViewControllerProtocol) {
        self.data = data
        self.viewController = viewController
        super.init(frame: CGRect.zero)
        initFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("ResultsViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    // MARK: - Private methods
    
}

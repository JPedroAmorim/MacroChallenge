//
//  SchoolViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewImplementation: UIView, SchoolViewProtocol {
    // MARK: - IBOutlets

    
    // MARK: - Dependencies
    var viewController: SchoolViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: School
    
    // MARK: - Init methods
    required init(data: School, controller: SchoolViewControllerProtocol) {
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
        if let nib = Bundle.main.loadNibNamed("SchoolViewImplementation", owner: self, options: nil),
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
       
    }
}

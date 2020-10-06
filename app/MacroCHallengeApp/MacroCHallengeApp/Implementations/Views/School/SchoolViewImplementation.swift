//
//  SchoolViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewImplementation: UIView, SchoolViewProtocol {
    // MARK: - IBOutlets
    
    // Notice
    @IBOutlet weak var noticeViewCard: UIView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeImage: UIImageView!
    
    // Tests
    @IBOutlet weak var testTableView: UITableView!
    
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
        self.addingShadowOnElement(view: self.noticeViewCard)
        self.setVisualElements()
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
    
    /**
     
     Método responsável por adicionar sombras nos elementos UIView.
     
     */
    private func addingShadowOnElement(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
    }
    
}

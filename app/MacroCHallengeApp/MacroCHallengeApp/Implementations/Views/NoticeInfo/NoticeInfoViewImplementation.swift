//
//  NoticeInfoViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 26/10/20.
//

import Foundation
import UIKit

class NoticeInfoViewImplementation: UIView, NoticeInfoViewProtocol {
    
    // MARK: - IBOutlets
    
    
    // MARK: - Dependencies
    var viewController: NoticeInfoViewControllerProtocol
    
    // MARK: - Private attributes
    private var topic: [String]?
    private var numberOfQuestions: Int?
    private var essay: [String : String]?
    
    // MARK: - Init methods
    required init(_ topic: [String]?, _ numberOfQuestions: Int?, _ essay: [String : String]?, controller: NoticeInfoViewControllerProtocol) {
        self.topic = topic
        self.numberOfQuestions = numberOfQuestions
        self.essay = essay
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

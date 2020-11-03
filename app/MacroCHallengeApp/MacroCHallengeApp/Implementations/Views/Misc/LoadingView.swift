//
//  LoadingView.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 02/11/20.
//

import Foundation
import UIKit

class LoadingView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblText: UILabel!
    
    // MARK: - Lifecycle
    required init(message: String, error: Bool) {
    
        super.init(frame: CGRect.zero)
        
        if let nib = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil), let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
            self.lblText.text = message
            self.activityIndicator.isHidden = error
            error ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

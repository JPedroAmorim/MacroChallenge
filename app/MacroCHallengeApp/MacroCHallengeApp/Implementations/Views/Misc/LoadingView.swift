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
    @IBOutlet weak var lblLoadingMessage: UILabel!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    // MARK: - Lifecycle
    required init(message: String, error: Bool) {
    
        super.init(frame: CGRect.zero)
        
        if let nib = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil), let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
            if error {
                lblErrorMessage.text = message
                lblErrorMessage.isHidden = false
                lblLoadingMessage.isHidden = true
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
            } else {
                lblLoadingMessage.text = message
                lblLoadingMessage.isHidden = false
                lblErrorMessage.isHidden = true
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            }
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

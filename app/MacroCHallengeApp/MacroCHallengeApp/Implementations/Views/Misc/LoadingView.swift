//
//  LoadingView.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 02/11/20.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    required init() {
        
        super.init(frame: CGRect.zero)
        if let nib = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil), let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
            activityIndicator.startAnimating()
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

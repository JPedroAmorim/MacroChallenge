//
//  OverviewViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 07/10/20.
//

import UIKit

class OverviewViewControllerImplementation: UIViewController, OverviewViewControllerProtocol {

	func questionWasSubmitted(_ question: Question) {
		print("questionWasSubmitted")
	}

    // MARK: - Dependencies
    var myView: OverviewViewProtocol?
    
    // MARK: - Private attributes
    private var data: Test
    
    // MARK: - Init methods
    required init(data: Test) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        setupDefaultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup methods
    private func setupDefaultView() {
        let defaultView = OverviewViewImplementation(data: self.data, controller: self)
        self.myView = defaultView
        self.view = defaultView
    }
}

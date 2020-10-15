//
//  SchoolViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewControllerImplementation: UIViewController, SchoolViewControllerProtocol {
    // MARK: - Dependencies
    var myView: SchoolViewProtocol?
    
    // MARK: - Private attributes
    private var data: School
    
    // MARK: - Init methods
    required init(data: School) {
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
        let defaultView = SchoolViewImplementation(data: self.data, controller: self)
        self.myView = defaultView
        self.view = defaultView
        self.title = data.name
    }
    
    // MARK: - SchoolViewControllerProtocol methods
    func testWasSubmitted(_ test: Test) {
        if let navController = self.navigationController {
            let overviewViewController = OverviewViewControllerImplementation(data: test)
            navController.pushViewController(overviewViewController, animated: true)
        }
    }
    
    func noticeWasSubmitted(_ notice: [String : String]) {
        // TODO: Implementação desse método. Por enquanto, ele está fora do escopo da estória que estamos atacando.
    }
}

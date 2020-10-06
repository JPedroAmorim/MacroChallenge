//
//  SchoolsViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolsViewControllerImplementation: UIViewController, SchoolsViewControllerProtocol {
   // MARK: - Dependencies
    var myView: SchoolsViewProtocol?
    var schools: Schools?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private setupDefaultSchoolsImplentation() {
    }
    
    // MARK: - SchoolViewControllerProtocol methods
    func schoolWasSubmitted(_ school: School) {
        
    }
}

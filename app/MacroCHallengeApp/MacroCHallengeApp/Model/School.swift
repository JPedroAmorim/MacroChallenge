//
//  School.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 05/10/20.
//

import Foundation
import UIKit

class School {
    var name: String
    var location: [String]
    var logo: UIImage
    var notice: [String:String]
    var tests: [Test]
    
    init(name: String, location: [String], logo: UIImage, notice: [String:String], tests: [Test]) {
        self.name = name
        self.location = location
        self.logo = logo
        self.notice = notice
        self.tests = tests
    }
}

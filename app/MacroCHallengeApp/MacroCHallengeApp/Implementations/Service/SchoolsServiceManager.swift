//
//  TempMock.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 29/10/20.
//

import Foundation
import UIKit

class SchoolsServiceManager: SchoolsProtocol {
    
    // MARK: - Protocol functions
    func getSchools() -> [School] {
        return schools
    }
    
    
    // MARK: - Private vars
    
    private let schools: [School] = [
        School(name: "Cotuca",
               location: ["Campinas"],
               logo: UIImage(named: "logoCOTUCA")!,
               notice: getNotice(),
               tests: [TestHeader(name: "cotuca", year: "2020"),
                       TestHeader(name: "cotuca", year: "2019"),
                       TestHeader(name: "cotuca", year: "2018"),
                       TestHeader(name: "cotuca", year: "2017"),
                       TestHeader(name: "cotuca", year: "2016")])]
}

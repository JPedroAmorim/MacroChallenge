//
//  MockSchoolsImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import Foundation
import UIKit

class MockSchoolsImplementation: SchoolsProtocol {
    // MARK: - SchoolsProtocol methods
    func getSchools() -> [School] {
        return hardCodedSchools()
    }
    
    /**
     
     Método que retorna escolas a partir do hardcoding delas. É necessário fazer o hardcoding dos atributos da escola também: (provas, questões...)
     
     -returns: Um array que contém todas as escolas hardcoded.
     
     */
    
    // TODO: Realmente isso aqui foi só um teste pra ver se funciona. Provavelmente uma ideia melhor é realmente copiar umas questões
    // de uma prova de vestibulinho com imagens e tal.
    private func hardCodedSchools() -> [School] {
        let firstDummyQuestion = Question(number: "1", text: "Questão de teste 1", initialText: nil, image: nil,
                                          subtitle: nil, options: ["a":"20", "b":"50", "c":"50", "d":"10", "e":"10"], answer: "a")
        let secondDummyQuestion = Question(number: "1", text: "Questão de teste 2", initialText: nil, image: nil,
                                           subtitle: nil, options: ["a":"20", "b":"50", "c":"50", "d":"10", "e":"10"], answer: "a")
        let thirdDummyQuestion = Question(number: "1", text: "Questão de teste 3", initialText: nil, image: nil,
                                          subtitle: nil, options: ["a":"20", "b":"50", "c":"50", "d":"10", "e":"10"], answer: "a")
        
        let dummyTest = Test(name: "Vestibulinho", year: "2002", questions: [firstDummyQuestion, secondDummyQuestion, thirdDummyQuestion])
        
        let dummySchool = School(name: "Escola teste", location: ["Aqui"], logo: UIImage(), notice: ["date":"a"], tests: [dummyTest])
        
        return [dummySchool]
    }
}

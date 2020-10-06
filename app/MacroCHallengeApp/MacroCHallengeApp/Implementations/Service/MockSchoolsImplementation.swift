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
        let firstDummyQuestion = Question(number: "1",
                                          text: "O efeito de humor da tira ocorre com a interpretação equivo- cada que o segundo personagem faz do termo",
                                          initialText: "Leia a tira.",
                                          image: UIImage(named: "CTI2020questionImage01"),
                                          subtitle: "(Mort Walker, “Recruta Zero”. Em: https://cultura.estadao.com.br/quadrinhos)",
                                          options: ["a":"sargento.", "b":"exposição.", "c":"ele.", "d":"venceu."],
                                          answer: "c")
        let secondDummyQuestion = Question(number: "16",
                                           text: "João ganhou R$ 300,00 de aniversário e utilizou esse dinhei- ro para comprar uma camiseta, uma calça e uma bermuda. A camiseta custou desse valor mais R$ 10,00, e a calça custou desse valor mais R$ 20,00. Com o valor restante foi possível comprar a bermuda e ainda sobraram R$ 45,00. O valor da bermuda foi",
                                           initialText: nil,
                                           image: nil,
                                           subtitle: nil,
                                           options: ["a":"R$ 60,00.",
                                                     "b":"R$ 75,00.",
                                                     "c":"R$ 90,00.",
                                                     "d":"R$ 105,00."],
                                           answer: "b")
        let thirdDummyQuestion = Question(number: "18",
                                          text: "Andrea colocou 3 músicas em seu pen drive. A primeira música tinha duração de 3 minutos e 48 segundos, e a segunda músi- ca tinha duração de 2 minutos e 52 segundos. Sabendo que a duração das 3 músicas juntas era de 9 minutos e 15 segundos, então, a duração da terceira música era de",
                                          initialText: nil,
                                          image: nil,
                                          subtitle: nil,
                                          options: ["a":"2 minutos e 35 segundos.",
                                                    "b":"2 minutos e 45 segundos.",
                                                    "c":"2 minutos e 55 segundos.",
                                                    "d":"3 minutos e 05 segundos."],
                                          answer: "a")
        
        let dummyTest = Test(name: "Vestibulinho", year: "2020", questions: [firstDummyQuestion, secondDummyQuestion, thirdDummyQuestion])
        
        
        let dummySchool = School(name: "Colégio Técnico Industrial",
                                 location: ["Bauru, Guaratinguetá, Jaboticabal"],
                                 logo: UIImage(named: "logoCTI")!,
                                 notice: ["date":"a"],
                                 tests: [dummyTest])
        
        return [dummySchool]
    }
}

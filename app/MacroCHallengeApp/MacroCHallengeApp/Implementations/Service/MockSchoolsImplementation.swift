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
     
     - returns: Um array que contém todas as escolas hardcoded.
     
     */
    
    private func hardCodedSchools() -> [School] {
        guard let imgCti1 = UIImage(named: "CTI2020questionImage01") else {return []}
        guard let imgCotuca1 = UIImage(named: "COTUCA2019questionImage04") else {return []}
        guard let imgCotuca2 = UIImage(named: "COTUCA2019questionImage14") else {return []}

        let CtiFirstDummyQuestion = Question(number: "1",
                                          text: "O efeito de humor da tira ocorre com a interpretação equivo- cada que o segundo personagem faz do termo",
                                          initialText: "Leia a tira.",
                                          images: [imgCti1],
                                          subtitle: "(Mort Walker, “Recruta Zero”. Em: https://cultura.estadao.com.br/quadrinhos)",
                                          options: ["a":"sargento.", "b":"exposição.", "c":"ele.", "d":"venceu."],
                                          answer: "c")
        let CtiSecondDummyQuestion = Question(number: "16",
                                           text: "João ganhou R$ 300,00 de aniversário e utilizou esse dinhei- ro para comprar uma camiseta, uma calça e uma bermuda. A camiseta custou desse valor mais R$ 10,00, e a calça custou desse valor mais R$ 20,00. Com o valor restante foi possível comprar a bermuda e ainda sobraram R$ 45,00. O valor da bermuda foi",
                                           initialText: nil,
                                           images: nil,
                                           subtitle: nil,
                                           options: ["a":"R$ 60,00.",
                                                     "b":"R$ 75,00.",
                                                     "c":"R$ 90,00.",
                                                     "d":"R$ 105,00."],
                                           answer: "b")
        let CtiThirdDummyQuestion = Question(number: "18",
                                          text: "Andrea colocou 3 músicas em seu pen drive. A primeira música tinha duração de 3 minutos e 48 segundos, e a segunda músi- ca tinha duração de 2 minutos e 52 segundos. Sabendo que a duração das 3 músicas juntas era de 9 minutos e 15 segundos, então, a duração da terceira música era de",
                                          initialText: nil,
                                          images: nil,
                                          subtitle: nil,
                                          options: ["a":"2 minutos e 35 segundos.",
                                                    "b":"2 minutos e 45 segundos.",
                                                    "c":"2 minutos e 55 segundos.",
                                                    "d":"3 minutos e 05 segundos."],
                                          answer: "a")
        
        let CotucaFirstDummyQuestion = Question(number: "4",
                                          text: "Sobre a tirinha de Laerte a seguir e a letra da música “Triste, louca ou má”, é possível afirmar que:",
                                          initialText: "Leia a tira.",
                                          images: [imgCotuca1],
                                          subtitle: "http://oplanetabomba.blogspot.com/2015/10/o-fundamentalismo-e-tentativa-de-moldar.html. Acesso em: 29/07/2018.",
                                          options: ["a":"ambos os textos possuem uma relação temática ao problematizarem a ideia de normatização de certos comportamentos sociais.",
                                                    "b":"ambos os textos possuem uma relação temática ao afirmarem a necessidade de superação do conceito tradicional de família.",
                                                    "c":"os textos se relacionam de modo contrastivo ao problematizarem a noção de família na sociedade moderna.",
                                                    "d":"os textos se relacionam de modo contrastivo, pois a tirinha de Laerte está centrada na afirmação do estereótipo da família contemporânea, enquanto a música “Triste, louca ou má” concentra-se na superação do papel atribuído à mulher na sociedade moderna.",
                                                    "e":"os textos se relacionam de modo contrastivo, pois a tirinha de Laerte está centrada na superação do estereótipo da família contemporânea, enquanto a música “Triste, louca ou má” concentra-se na afirmação do papel atribuído à mulher na sociedade moderna."],
                                          answer: "a")
        let CotucaSecondDummyQuestion = Question(number: "14",
                                           text: "Desse modo, um cliente que almoçar dez vezes e ganhar o almoço por conta do restaurante ganhará um desconto cujo valor, aproximadamente, equivale a:",
                                           initialText: "Um restaurante faz uma promoção, com a seguinte regra, a seus clientes fidelizados:",
                                           images: [imgCotuca2],
                                           subtitle: nil,
                                           options: ["a":"8,9%.",
                                                     "b":"9,1%.",
                                                     "c":"10%.",
                                                     "d":"11,1%."],
                                           answer: "b")
        let CotucaThirdDummyQuestion = Question(number: "16",
                                          text: "Uma fruta in natura possui 80% de sua massa composta de água e, se for desidratada, a água se reduz a 10% da massa após esse processo. Qual é a massa (em gramas) dessa fruta in natura que corresponderia a uma porção de 100 g dessa mesma fruta em sua forma desidratada?",
                                          initialText: nil,
                                          images: nil,
                                          subtitle: nil,
                                          options: ["a":"900g",
                                                    "b":"890g",
                                                    "c":"800g",
                                                    "d":"450g",
                                                    "e":"170g"],
                                          answer: "d")
        
        
        let dummyTest: [Test] = [Test(name: "Prova 2020", year: "2020",
                                      questions: [CtiFirstDummyQuestion, CtiSecondDummyQuestion, CtiThirdDummyQuestion]),
                                 Test(name: "COTUCA 2019", year: "2019",
                                      questions: [CotucaFirstDummyQuestion, CotucaSecondDummyQuestion, CotucaThirdDummyQuestion])]
        
        
        let dummySchool: [School] = [School(name: "Colégio Técnico Industrial",
                                            location: ["Bauru, Guaratinguetá, Jaboticabal"],
                                            logo: UIImage(named: "logoCTI")!,
                                            notice: ["date":"17.11.2019"],
                                            tests: [dummyTest[0]]),
                                     School(name: "COTUCA",
                                            location: ["Campinas"],
                                            logo: UIImage(named: "logoCOTUCA")!,
                                            notice: ["date":"09.12.2018"],
                                            tests: [dummyTest[1]])]
        
        return dummySchool
    }
}

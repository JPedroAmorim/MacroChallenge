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
        
        let CtiFirstDummyQuestion = Question(number: "1",
                                          text: "O efeito de humor da tira ocorre com a interpretação equivo- cada que o segundo personagem faz do termo",
                                          initialText: "Leia a tira.",
                                          images: [imgCti1],
                                          subtitle: "(Mort Walker, “Recruta Zero”. Em: https://cultura.estadao.com.br/quadrinhos)",
                                          options: ["a":"sargento.", "b":"exposição.", "c":"ele.", "d":"venceu."],
                                          answer: "c",
                                          topic: "Português")
        let CtiSecondDummyQuestion = Question(number: "2",
                                           text: "João ganhou R$ 300,00 de aniversário e utilizou esse dinhei- ro para comprar uma camiseta, uma calça e uma bermuda. A camiseta custou desse valor mais R$ 10,00, e a calça custou desse valor mais R$ 20,00. Com o valor restante foi possível comprar a bermuda e ainda sobraram R$ 45,00. O valor da bermuda foi",
                                           initialText: nil,
                                           images: nil,
                                           subtitle: nil,
                                           options: ["a":"R$ 60,00.",
                                                     "b":"R$ 75,00.",
                                                     "c":"R$ 90,00.",
                                                     "d":"R$ 105,00."],
                                           answer: "b",
                                           topic: "Matemática")
        let CtiThirdDummyQuestion = Question(number: "3",
                                          text: "Andrea colocou 3 músicas em seu pen drive. A primeira música tinha duração de 3 minutos e 48 segundos, e a segunda músi- ca tinha duração de 2 minutos e 52 segundos. Sabendo que a duração das 3 músicas juntas era de 9 minutos e 15 segundos, então, a duração da terceira música era de",
                                          initialText: nil,
                                          images: nil,
                                          subtitle: nil,
                                          options: ["a":"2 minutos e 35 segundos.",
                                                    "b":"2 minutos e 45 segundos.",
                                                    "c":"2 minutos e 55 segundos.",
                                                    "d":"3 minutos e 05 segundos."],
                                          answer: "a",
                                          topic: "Matemática")
        
        // Vestibulinho COTUCA 2018
        let Cotuca2018FirstDummyQuestion = Question(number: "1",
                                                    text: "Para uma festa de casamento, foram comprados 560 doces. Essa quantia era suficiente para dividi-los igualmente entre todos os convidados. No dia do casamento, 10 pessoas não puderam comparecer, fazendo com que cada convidado recebesse 1 doce a mais. Se N é o número que representa o total de pessoas que foram convidadas para a festa, então:",
                                                    initialText: nil,
                                                    images: nil,
                                                    subtitle: nil,
                                                    options: ["a":"40 ≤ 𝑁 < 52",
                                                              "b":"52 ≤ 𝑁 < 64",
                                                              "c":"64 ≤ 𝑁 < 76",
                                                              "d":"76 ≤ 𝑁 < 88",
                                                              "e":"88 ≤ 𝑁 < 100"],
                                                    answer: "d",
                                                    topic: "Matemática")
        let Cotuca2018SecondDummyQuestion = Question(number: "2",
                                                     text: "Se √𝑥 = 1+ √3, qual é o valor de 𝑥 2 ?",
                                                     initialText: nil,
                                                     images: nil,
                                                     subtitle: nil,
                                                     options: ["a":"28 + 16√3",
                                                               "b":"24 + 8√3",
                                                               "c":"16 + 12√3",
                                                               "d":"18 + 20√3",
                                                               "e":"22 + 14√3"],
                                                     answer: "a",
                                                     topic: "Matemática")
        let Cotuca2018ThirdDummyQuestion = Question(number: "3",
                                                    text: "Em uma festa de aniversário, o número de adultos era igual a 60% do número de crianças. Após a chegada de mais 12 crianças e 4 adultos, o número de crianças passou a ser o dobro do número de adultos. Depois disso, o total de pessoas presentes na festa (crianças e adultos) é um número cuja soma dos algarismos é igual a:",
                                                    initialText: nil,
                                                    images: nil,
                                                    subtitle: nil,
                                                    options: ["a":"8",
                                                              "b":"9",
                                                              "c":"10",
                                                              "d":"12",
                                                              "e":"15"],
                                                    answer: "d",
                                                    topic: "Matemática")
        
        // Vestibulinho COTUCA 2019
        let Cotuca2019FirstDummyQuestion = Question(number: "1",
                                                    text: "Sobre a tirinha de Laerte a seguir e a letra da música “Triste, louca ou má”, é possível afirmar que:",
                                                    initialText: "Leia a tira.",
                                                    images: [UIImage(named: "COTUCA2019questionImage04")!],
                                                    subtitle: "http://oplanetabomba.blogspot.com/2015/10/o-fundamentalismo-e-tentativa-de-moldar.html. Acesso em: 29/07/2018.",
                                                    options: ["a":"ambos os textos possuem uma relação temática ao problematizarem a ideia de normatização de certos comportamentos sociais.",
                                                              "b":"ambos os textos possuem uma relação temática ao afirmarem a necessidade de superação do conceito tradicional de família.",
                                                              "c":"os textos se relacionam de modo contrastivo ao problematizarem a noção de família na sociedade moderna.",
                                                              "d":"os textos se relacionam de modo contrastivo, pois a tirinha de Laerte está centrada na afirmação do estereótipo da família contemporânea, enquanto a música “Triste, louca ou má” concentra-se na superação do papel atribuído à mulher na sociedade moderna.",
                                                              "e":"os textos se relacionam de modo contrastivo, pois a tirinha de Laerte está centrada na superação do estereótipo da família contemporânea, enquanto a música “Triste, louca ou má” concentra-se na afirmação do papel atribuído à mulher na sociedade moderna."],
                                                    answer: "a",
                                                    topic: "Português")
        let Cotuca2019SecondDummyQuestion = Question(number: "2",
                                                     text: "Desse modo, um cliente que almoçar dez vezes e ganhar o almoço por conta do restaurante ganhará um desconto cujo valor, aproximadamente, equivale a:",
                                                     initialText: "Um restaurante faz uma promoção, com a seguinte regra, a seus clientes fidelizados:",
                                                     images: [UIImage(named: "COTUCA2019questionImage14")!],
                                                     subtitle: nil,
                                                     options: ["a":"8,9%.",
                                                               "b":"9,1%.",
                                                               "c":"10%.",
                                                               "d":"10,9%",
                                                               "e":"11,1%."],
                                                     answer: "b",
                                                     topic: "Matemática")
        let Cotuca2019ThirdDummyQuestion = Question(number: "3",
                                                    text: "Uma fruta in natura possui 80% de sua massa composta de água e, se for desidratada, a água se reduz a 10% da massa após esse processo. Qual é a massa (em gramas) dessa fruta in natura que corresponderia a uma porção de 100 g dessa mesma fruta em sua forma desidratada?",
                                                    initialText: nil,
                                                    images: nil,
                                                    subtitle: nil,
                                                    options: ["a":"900g",
                                                              "b":"890g",
                                                              "c":"800g",
                                                              "d":"450g",
                                                              "e":"170g"],
                                                    answer: "d",
                                                    topic: "Matemática")
        
        // Vestibulinho ETEC 2019
        let Etec2019FirstDummyQuestion = Question(number: "1",
                                                  text: "Considerando os animais citados no texto, podemos afirmar que",
                                                  initialText: "Os primeiros animais surgiram nos mares e eram invertebrados de corpo mole. À medida que o tapete verde desenvolvia-se sobre a Terra, outro grupo de criaturas vivas – os artrópodes – chegava do mar para desfrutar dessa nova e enorme massa de alimentos. Os primeiros artrópodes que emergiram foram talvez os miriápodes primitivos, que atingiam aproximadamente dois metros de comprimento e apresentavam até duzentas patas. Depois vieram as lacraias, as aranhas e os escorpiões. Tempos depois, surgiram as libélulas gigantes, um dos primeiros insetos a voar, com até setenta centímetros de envergadura. O voo foi, talvez, desenvolvido para que esses insetos escapassem dos animais predadores, que os espreitavam no chão. As baratas, os gafanhotos e os grilos também faziam parte dos conjuntos de primeiros insetos que apareceram.",
                                                  images: nil,
                                                  subtitle: nil,
                                                  options: ["a":"todos possuem asas, corpo mole e segmentado",
                                                            "b":"as lacraias apresentam endoesqueleto calcário e patas articuladas.",
                                                            "c":"os gafanhotos, os grilos e as aranhas possuem um par de antenas e quatro pares de patas.",
                                                            "d":"as libélulas possuem exoesqueleto, três pares de patas e corpo segmentado em cabeça, tórax e abdome.",
                                                            "e":"as baratas, as aranhas e os escorpiões apresentam glândulas de veneno, exoesqueleto e corpo não segmentado. "],
                                                  answer: "d",
                                                  topic: "Ciências Naturais")

        let Etec2019SecondDummyQuestion = Question(number: "2",
                                                   text: "O texto faz referência a um período muito conhecido da história da Humanidade, no qual surgiram os primeiros registros escritos. Assinale a alternativa que, corretamente, descreve o contexto em que surgiu a escrita na Mesopotâmia.",
                                                   initialText: "Em 1929, o arqueólogo alemão Julius Jordan desenterrou uma vasta biblioteca de tábuas de argila com um tipo de escrita conhecida como “cuneiforme”, com cinco mil anos de idade, mais antigas que exemplares semelhantes encontrados na China, no Egito e na América. As tábuas estavam em Uruk, uma cidade mesopotâmica – e uma das primeiras do mundo – às margens do rio Eufrates, onde hoje fica o Iraque. As tábuas não haviam sido usadas para escrever poesia ou enviar mensagens a lugares remotos. Foram empregadas para fazer contas – e também para elaborar os primeiros contratos.",
                                                   images: nil,
                                                   subtitle: "<https://tinyurl.com/ycuj8mq6> Acesso em: 26.10.2018. Adaptado.",
                                                   options: ["a":"Os mesopotâmicos criaram a escrita como forma de se comunicar com os deuses, entalhando placas de argila que eram cuidadosamente depositadas no interior dos templos religiosos. ",
                                                             "b":"O surgimento da escrita foi vinculado à criação de um sistema de educação segundo o qual todas as crianças deveriam dominar o conhecimento das letras e dos cálculos.",
                                                             "c":"As cidades da Mesopotâmia eram separadas por longas distâncias, percorridas a pé por mensageiros que levavam cartas e ofícios trocados entre os governantes.",
                                                             "d":"A evolução da literatura oral gerou a necessidade de registrar os textos poéticos declamados pelos grandes oradores da Antiguidade clássica.",
                                                             "e":"O desenvolvimento do comércio levou à criação da escrita, utilizada, inicialmente, para realizar registros contábeis e firmar contratos."],
                                                   answer: "e",
                                                   topic: "História")
        let Etec2019ThirdDummyQuestion = Question(number: "3",
                                                  text: "Um país que se candidate a membro desse bloco econômico deve necessariamente",
                                                  initialText: "O Tratado da União Europeia estabelece que qualquer país europeu pode se candidatar à adesão ao bloco. Porém, um país só pode entrar na União Europeia se cumprir alguns critérios de adesão.",
                                                  images: nil,
                                                  subtitle: nil,
                                                  options: ["a":"ser republicano e possuir economia de mercado, porém submetida a controles constantes por parte do Fundo Monetário Internacional (FMI).",
                                                            "b":"permanecer fiel à legislação do bloco e delegar suas questões de segurança nacional à Organização do Tratado do Atlântico Norte (OTAN).",
                                                            "c":"possuir regime monarquista de governo, aceitar a política econômica do bloco e se comprometer a utilizar o Euro.",
                                                            "d":"estar situado na Europa Ocidental e substituir sua Câmara de Deputados e seu Senado pelo Parlamento Europeu.",
                                                            "e":"ter instituições estáveis que garantam a democracia, o Estado de direito e o respeito aos direitos humanos."],
                                                  answer: "e",
                                                  topic: "História")
        
        // Vestibulinho ETEC 2020
        let Etec2020FirstDummyQuestion = Question(number: "1",
                                                  text: "Analise as alternativas e assinale a correta",
                                                  initialText: "Um número natural, diferente de zero e diferente de um, pode ser classificado como primo ou composto.Os quadrinhos fornecem algumas pistas sobre o que permite caracterizar um número para que ele seja dito primo.",
                                                  images: [UIImage(named: "ETEC2020questionImage01")!],
                                                  subtitle: "<https://tinyurl.com/y2xxx63q> Acesso em: 07.10.2019. Original colorido.",
                                                  options: ["a":"O número 6 056 529 316 217 não é primo, e por isso está distante do restante.",
                                                            "b":"Como os números 37 e 73 são primos, então 16 e 61 também são.",
                                                            "c":"O número 237 é um número primo, assim como o 37 e o 137.",
                                                            "d":"Todo número primo é ímpar e só pode terminar em 1, 3, 7 ou 9.",
                                                            "e":"Há apenas quatro números primos que são menores do que 10."],
                                                  answer: "e",
                                                  topic: "Matemática")

        let Etec2020SecondDummyQuestion = Question(number: "2",
                                                   text: "Assim, na pele, entre os fatores que contribuem para a manutenção da temperatura corporal em dias frios, em ambientes abertos, destacam-se",
                                                   initialText: "A pele, maior órgão do corpo humano, é importante na manutenção da saúde porque reveste toda a superfície corporal, atuando, entre outras coisas, na proteção contra germes e raios solares, e é também responsável pela sensibilidade tátil e pela manutenção da temperatura corporal. O ser humano apresenta a temperatura corporal normal de 36,5 ºC. A elevação ou redução dessa temperatura pode ter efeitos danosos ao organismo.",
                                                   images: nil,
                                                   subtitle: nil,
                                                   options: ["a":"a dilatação dos vasos sanguíneos periféricos e maior eliminação de oleosidade pelas glândulas sebáceas.",
                                                             "b":"a dilatação dos vasos sanguíneos periféricos e maior eliminação de suor pelas glândulas sudoríparas.",
                                                             "c":"a dilatação dos vasos sanguíneos periféricos e eliminação contínua de suor pelas glândulas sebáceas.",
                                                             "d":"a contração dos vasos sanguíneos periféricos e menor eliminação de suor pelas glândulas sudoríparas.",
                                                             "e":"a contração dos vasos sanguíneos periféricos e maior eliminação de suor pelas glândulas sebáceas."],
                                                   answer: "d",
                                                   topic: "Matemática")
        let Etec2020ThirdDummyQuestion = Question(number: "3",
                                                  text: "De acordo com o texto, é correto afirmar que",
                                                  initialText: "Sabemos que a humanidade é capaz de produzir o necessário para banir do planeta o problema da subalimentação. Apesar disso, a fome no mundo concentra-se em países da África subsaariana (e, em menor proporção, na Índia e no Paquistão) e persiste por causa do protecionismo econômico dos países ricos. A esmagadora maioria dos que não conseguem preencher suas necessidades básicas vive em regiões rurais, e a escassa renda que obtêm deriva da agricultura. Aumentar a produção agropecuária é fundamental, como bem sublinhou o secretário-geral da ONU, mas o mais importante é criar condições para que os que vivem em situação de pobreza absoluta conquistem o direito de produzir a própria alimentação.",
                                                  images: nil,
                                                  subtitle: "<https://tinyurl.com/y3837qsq> Acesso em: 01.10.2019. Adaptado",
                                                  options: ["a":"a subalimentação inexiste em países considerados subdesenvolvidos.",
                                                            "b":"a subalimentação atinge principalmente os moradores das áreas urbanas.",
                                                            "c":"o aumento da produção industrial acabará com o problema da subalimentação.",
                                                            "d":"é possível acabar com o problema da subalimentação no mundo em que vivemos.",
                                                            "e":"é a proteção militar dada pelos países pobres aos países ricos que causa a subalimentação."],
                                                  answer: "d",
                                                  topic: "História")
        
        let dummyTest: [Test] = [Test(name: "Prova 2019",
                                      year: "2019",
                                      questions: [CtiFirstDummyQuestion,
                                                  CtiSecondDummyQuestion,
                                                  CtiThirdDummyQuestion]),
                                 Test(name: "Prova 2018",
                                      year: "2018",
                                      questions: [Cotuca2019FirstDummyQuestion,
                                                  Cotuca2019SecondDummyQuestion,
                                                  Cotuca2019ThirdDummyQuestion]),
                                 Test(name: "Prova 2017",
                                      year: "2017",
                                      questions: [Cotuca2018FirstDummyQuestion,
                                                  Cotuca2018SecondDummyQuestion,
                                                  Cotuca2018ThirdDummyQuestion]),
                                 Test(name: "Prova 2019",
                                      year: "2019",
                                      questions: [Etec2020FirstDummyQuestion,
                                                  Etec2020SecondDummyQuestion,
                                                  Etec2020ThirdDummyQuestion]),
                                 Test(name: "Prova 2019",
                                      year: "2019",
                                      questions: [Etec2019FirstDummyQuestion,
                                                  Etec2019SecondDummyQuestion,
                                                  Etec2019ThirdDummyQuestion])]
        
        
        let dummySchool: [School] = [School(name: "Colégio Técnico Industrial",
                                            location: ["Bauru, Guaratinguetá, Jaboticabal"],
                                            logo: UIImage(named: "logoCTI")!,
                                            notice: ["date":"17.11.2019"],
                                            tests: [dummyTest[0]]),
                                     School(name: "COTUCA",
                                            location: ["Campinas"],
                                            logo: UIImage(named: "logoCOTUCA")!,
                                            notice: ["date":"09.12.2018"],
                                            tests: [dummyTest[1], dummyTest[2]]),
                                     School(name: "ETEC",
                                            location: ["Estado de São Paulo"],
                                            logo: UIImage(named: "logoETEC")!,
                                            notice: ["date":"15.12.2019"],
                                            tests: [dummyTest[3], dummyTest[4]])]
        
        return dummySchool
    }
}

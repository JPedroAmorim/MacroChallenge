//
//  ConverterResultsDataJSONProtocol.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 30/10/20.
//

import SwiftyJSON
import Foundation

protocol ConverterResultsDataJSONProtocol {
    /**
    Função responsável por converter um objeto JSON em um objeto da classe ResultsData que representa os resultados de uma prova.

    - parameter json: Objeto JSON com dados de resultados de uma prova a ser convertida para objeto ResultsData .

    */
    func createResultsData(json: JSON) throws -> ResultsData
}

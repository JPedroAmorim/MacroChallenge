//
//  RequestSenderImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 26/10/20.
//

import Foundation
import Alamofire
import SwiftyJSON


class RequestSenderImplementation: RequestSenderProtocol {
    
    private var parser = ConverterJSON()
    
    func getQuestionsForTestRequest(testName: String, testYear: String, completion: @escaping ([Question]) -> Void, onFailure: @escaping  (String) -> Void) {
        guard let url = URL(string: rootBackendURL + "tests?testName=\(testName)&testYear=\(testYear)") else {
            onFailure("Erro ao decodificar a URL")
            return
        }
        
         sendGetRequestForUrl(url) { jsonResponse, error in
            guard let jsonResponseArray = jsonResponse?.array else {
                onFailure("Erro ao processar resposta do servidor")
                return
            }
            let questionsArrayForTest =  self.parser.createQuestions(jsonArray: jsonResponseArray)
            completion(questionsArrayForTest)
        }
    }
    
    private func sendGetRequestForUrl(_ url: URL, completion: @escaping (JSON?, String?) -> Void)  {
        var errorMessage: String?
    
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                
                switch response.result {
                case.success:
                    
                    guard let responseValue = response.value else { return }
                    let jsonResponse = JSON(responseValue)
                    
                    completion(jsonResponse, nil)
                    
                case .failure:
                    
                    if let data = response.data {
                        errorMessage = String(decoding: data, as: UTF8.self)
                    } else {
                        errorMessage = "Erro ao se conectar ao servidor"
                    }
                    
                    completion(nil, errorMessage)
                }
            }
    }
}

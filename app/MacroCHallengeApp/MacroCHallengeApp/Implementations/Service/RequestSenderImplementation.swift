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
    func getQuestionsForTestRequest(testName: String, testYear: String, completion: ([Question]) -> Void, onFailure: (String) -> Void) {
        guard let url = URL(string: rootBackendURL + "/tests?testName=\(testName)&testYear=\(testYear)") else {
            onFailure("Erro ao decodificar a URL")
            return
        }
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
            
                switch response.result {
                case.success:
                    return
                case .failure:
                    if let data = response.data {
                        let errorString = String(decoding: data, as: UTF8.self)
                    }
                
                }
        }
        
        
    }
    

}

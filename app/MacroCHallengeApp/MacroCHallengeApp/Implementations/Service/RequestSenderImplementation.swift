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
        
    }
}

//
//  RequestSender.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 26/10/20.
//

import Foundation

protocol RequestSenderProtocol {
    func sendTestsHeaderForSchoolRequest(schoolName: String, completion: ([TestHeader]) -> Void, onFailure: (String) -> Void)
    func sendQuestionsForTestRequest(testName: String, testYear: String, completion: (Test) -> Void, onFailure: (String) -> Void)
}

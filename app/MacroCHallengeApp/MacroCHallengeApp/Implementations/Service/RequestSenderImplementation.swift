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
    
    private var parser = ConverterQuestionsJSON()
    private var parserForGeneralResults = ConverterResultsJSON()
    private var parserForTestResults = ConverterResultsDataJSON()
    private var parserForTestHeader = ConverterTestHeaderJSON()
    
    func getSchoolAndTestHeaders(completion: @escaping([School]?, String?) -> Void) {
        
        guard let url = URL(string: rootBackendURL + "/schools") else {
            completion(nil, "Erro ao decodificar a URL")
            return
        }
        
        sendGetRequestForUrl(url) { jsonResponse, error in
            guard let jsonResponseArray = jsonResponse?.array else {
                completion(nil, "Erro ao processar resposta do servidor")
                return
            }
            
            let questions = self.parserForTestHeader.createSchools(jsonArray: jsonResponseArray)
            
            completion(questions, nil)
        }
    }
    
    func getAccumulatedResults(completion: @escaping(ResultsPerTopic?, [String : ResultsPerTopic]?, String?) -> Void) {
        guard let url = URL(string: rootBackendURL + "results/accumulated-results") else {
            completion(nil, nil, "Erro ao decodificar a URL")
            return
        }
        
        sendGetRequestForUrl(url, completion:  { jsonResponse, err in
            guard let jsonResponseArray = jsonResponse else {
                completion(nil, nil, "Erro ao processar resposta do servidor")
                return
            }
            let res = { () -> (ResultsPerTopic, [String:ResultsPerTopic])? in
                do {
                    let res = try self.parserForGeneralResults.createResultPerTopic(json: jsonResponseArray)
                    let result = try self.parserForGeneralResults.createDictionaryTopicsResults(json: jsonResponseArray)
                    return (res, result)
                } catch {
                    print("Error: \(error)")
                    return nil
                }
            }()
            
            if let r = res {
                completion(r.0, r.1, nil)
            } else {
                completion(nil, nil, "Erro ao fazer o parsing")
            }
            
        })
    }
    
    
    func getQuestionsForTestRequest(testName: String, testYear: String, completion: @escaping ([Question]?, String?) -> Void) {
        guard let url = URL(string: rootBackendURL + "tests?testName=\(testName)&testYear=\(testYear)") else {
            completion(nil, "Erro ao decodificar a URL")
            return
        }
        
        sendGetRequestForUrl(url) { jsonResponse, error in
            guard let jsonResponseArray = jsonResponse?.array else {
                completion(nil, "Erro ao processar resposta do servidor")
                return
            }
            let questionsArrayForTest =  self.parser.createQuestions(jsonArray: jsonResponseArray)
            completion(questionsArrayForTest, nil)
        }
    }
    
    func getQuestionsForQuestionsRequest(testName: String, topic: String, completion: @escaping ([Question]?, String?) -> Void) {
        guard let url = URL(string: rootBackendURL + "questions?schoolName=\(testName)&topic=\(topic)") else {
            completion(nil, "Erro ao decodificar a URL")
            return
        }
        
        sendGetRequestForUrl(url) { jsonResponse, error in
            guard let jsonResponseArray = jsonResponse?.array else {
                completion(nil, "Erro ao processar resposta do servidor")
                return
            }
            let questionsArrayForTest =  self.parser.createQuestions(jsonArray: jsonResponseArray)
            completion(questionsArrayForTest, nil)
        }
    }
    
    func getQuestionsAndAnsweredQuestions(testName: String, testYear: String, completion: @escaping ([Question]?, [String: String]?, String?) -> Void) {
        
        guard let userId = UserDefaults.standard.integer(forKey: "UserId") ?? nil else {
            completion(nil, nil, "Erro ao recuperar user id")
            return
        }
        
        guard let url = URL(string: rootBackendURL + "tests/test-result?testName=\(testName)&testYear=\(testYear)&userId=\(userId)") else {
            completion(nil, nil, "Erro ao decodificar a URL")
            return
        }
        
        sendGetRequestForUrl(url) { json, error in
            guard let jsonResponse = json else {
                completion(nil, nil, "Erro ao processar a resposta")
                return
            }
            
            guard let jsonArray = jsonResponse["questions"].array else {
                completion(nil, nil, "Erro ao processar a resposta")
                return
            }
            
            let questions = self.parser.createQuestions(jsonArray: jsonArray)
            
            let answeredQuestionsString = jsonResponse["answeredQuestions"].stringValue
            
            let answeredQuestionsDict = self.parserForTestResults.convertStringInADictionary(text: answeredQuestionsString)
            
            completion(questions, answeredQuestionsDict, nil)
        }
        
    }
    
    func postResultsForTest(testName: String, testYear: String, results: ResultsData, completion: @escaping (String?) -> Void) {
        
        guard let userId = UserDefaults.standard.integer(forKey: "UserId") ?? nil else {
            completion("Erro ao recuperar user id")
            return
        }
        
        guard let url = URL(string: rootBackendURL + "results?userId=\(userId)") else {
            completion("Erro ao decodificar a URL")
            return
        }
       

        let requestBody : [String: String] = ["testName": testName,
                                             "testYear": testYear,
                                             "totalPercentageOfCorrectAnswers": String(results.totalPercentageOfCorrectAnswers),
                                             "totalNumberOfQuestions": String(results.totalNumberOfQuestions),
                                             "totalNumberOfCorrectAnswers": String(results.totalNumberOfCorrectAnswers),
                                             "totalNumberOfAnsweredQuestions": String(results.totalNumberOfAnsweredQuestions),
                                             "correctAnswers": String(describing: results.correctAnswers),
                                             "wrongAnswers": String(describing: results.wrongAnswers),
                                             "answeredQuestions": String(describing: results.answeredQuestions),
                                             "resultsPerTopic": describeResultsPerTopicAsJSON(results.resultsPerTopic)]
        
        
        sendPostRequestForUrl(url: url, requestBody: requestBody) { error in
            if let errorMessage = error {
                completion(errorMessage)
            } else {
                completion(nil) // Tudo ocorreu bem
            }
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
    
    private func sendPostRequestForUrl(url: URL, requestBody: [String : String], completion: @escaping (String?) -> Void) {
        var errorMessage: String?
        
        AF.request(url, method: .post, parameters: requestBody, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                switch response.result {
                case.success:
                    completion(nil)
                    
                case .failure:
                    if let data = response.data {
                        errorMessage = String(decoding: data, as: UTF8.self)
                    } else {
                        errorMessage = "Erro ao se conectar ao servidor"
                    }
                    
                    completion(errorMessage)
                }
            }
    }
    
    private func describeResultsPerTopicAsJSON(_ resultsPerTopicDict: [String : ResultsPerTopic]) -> String {
        var resultString = "["
        
        for (key, value) in resultsPerTopicDict {
            resultString.append("{\"topic\":\"\(key)\", \"totalPercentageOfCorrectAnswers\":\(value.totalPercentageOfCorrectAnswers), \"totalNumberOfCorrectAnswers\":\(value.totalNumberOfCorrectAnswers), \"totalNumberOfAnsweredQuestions\":\(value.totalNumberOfAnsweredQuestions), \"totalNumberOfQuestions\":\(value.totalNumberOfQuestions)},")
        }
        
        resultString = String(resultString.dropLast())
        
        resultString.append("]")
        
        return resultString
    }
}

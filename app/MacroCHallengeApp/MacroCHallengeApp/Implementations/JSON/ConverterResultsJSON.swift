//
//  ConverterResultsJSON.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 30/10/20.
//

import SwiftyJSON
import Foundation

//    MARK: - Error Handling
enum ErrorResult: String, Error {
    
    case noTotalPercentageOfCorrectAnswers = "Não foi possível obter o número do total de percetagem de respostas corretas para criar objeto tipo ResultPerTopic, confira ConverterResulstJSON"
    case noTotalNumberOfCorrectAnswers = "Não foi possível obter o número do total de respostas corretas para criar objeto tipo ResultPerTopic, confira ConverterResulstJSON"
    case noTotalNumberOfAnsweredQuestions = "Não foi possível obter o número do total de respostas respondidas para criar objeto tipo ResultPerTopic, confira ConverterResulstJSON"
    case noTotalNumberOfQuestions = "Não foi possível obter o número do total de questões para criar objeto tipo ResultPerTopic, confira ConverterResulstJSON"
    case noTopic = "Não foi possível obter o tópico para criar o dicionário tipo [String:ResultPerTopic], confira ConverterResulstJSON"
}

class ConverterResulstJSON: ConverterResultsJSONProtocol  {
    //    MARK: - ConverterJSONProtocol methods\
    func createResultPerTopic(json: JSON) throws -> ResultsPerTopic {
        var totalPercentageOfCorrectAnswers: String
        var totalNumberOfQuestions: String
        var totalNumberOfCorrectAnswers: String
        var totalNumberOfAnsweredQuestions: String
        
        if let percentageOfCorrectAnswers = json["totalPercentageOfCorrectAnswers"].string {
            totalPercentageOfCorrectAnswers = percentageOfCorrectAnswers
        } else {
            throw ErrorResult.noTotalPercentageOfCorrectAnswers
        }
        
        if let numberOfQuestions = json["totalNumberOfQuestions"].string {
            totalNumberOfQuestions = numberOfQuestions
        } else {
            throw ErrorResult.noTotalNumberOfQuestions
        }
        
        if let numberOfCorrectAnswers = json["totalNumberOfCorrectAnswers"].string {
            totalNumberOfCorrectAnswers = numberOfCorrectAnswers
        } else {
            throw ErrorResult.noTotalNumberOfCorrectAnswers
        }
        
        if let numberOfAnsweredQuestions = json["totalNumberOfAnsweredQuestions"].string {
            totalNumberOfAnsweredQuestions = numberOfAnsweredQuestions
        } else {
            throw ErrorResult.noTotalNumberOfCorrectAnswers
        }
        
        let percentageOfCorrectAnswers = (totalPercentageOfCorrectAnswers as NSString).doubleValue
        let numberOfCorrectAnswers = (totalNumberOfCorrectAnswers as NSString).intValue
        let numberOfAnsweredQuestions = (totalNumberOfAnsweredQuestions as NSString).intValue
        let numberOfQuestions = (totalNumberOfQuestions as NSString).intValue
        
        let resultPertopic = ResultsPerTopic(totalPercentageOfCorrectAnswers: percentageOfCorrectAnswers,
                                             totalNumberOfCorrectAnswers: Int(numberOfCorrectAnswers),
                                             totalNumberOfAnsweredQuestions: Int(numberOfAnsweredQuestions),
                                             totalNumberOfQuestions: Int(numberOfQuestions))
        
        return resultPertopic
    }
    
    func createDictionaryTopicsResults(json: JSON) throws -> [String : ResultsPerTopic] {
        var resultsPerTopic: [String : ResultsPerTopic] = [:]
        var topic: String
        
        if let jsonArray = json["resultsPerTopic"].array {
            for jsonEntry in jsonArray {
                do {
                    if let topicJSON = jsonEntry["topic"].string {
                        topic = topicJSON
                    } else {
                        throw ErrorResult.noTopic
                    }
                    
                    let resultPerTopic = try createResultPerTopic(json: jsonEntry)
                    
                    resultsPerTopic[topic] = resultPerTopic
                } catch is ErrorResult {
                    continue
                } catch {
                    continue
                }
            }
        }
        
        return resultsPerTopic
    }
}


//
//  ConverterResultsDataJSONTests.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 30/10/20.
//

import SwiftyJSON
import Foundation

//    MARK: - Error Handling
enum ErrorResultsData: String, Error {
    
    case noTestName = "Não foi possível obter o nome da prova para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noYear = "Não foi possível obter o ano da prova para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noTotalPercentageOfCorrectAnswers = "Não foi possível obter o número da porcentagem de respostas corretas para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noTotalNumberOfQuestions = "Não foi possível obter o número total de questões para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noTotalNumberOfCorrectAnswers = "Não foi possível obter o número total de respostas corretas para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noTotalNumberOfAnsweredQuestions = "Não foi possível obter o número do total de respostas respondidas para criar objeto tipo ResultPerTopic, confira ConverterResultsDataJSON"
    case noCorrectAnswers = "Não foi possível obter as questões corretas para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noWrongAnswers = "Não foi possível obter as questões erradas para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case noAnsweredQuestions = "Não foi possível obter as questões respondidas para criar objeto tipo ResultsData, confira ConverterResultsDataJSON"
    case arrayResultsPerTopicIsEmpty = "Não foi possível obter o tópico para criar o dicionário tipo [String:ResultPerTopic] pois o array de tópicos está vazio, confira ConverterResultsDataJSON"
    case noTopic = "Não foi possível obter o tópico para criar o dicionário tipo [String:ResultPerTopic], confira ConverterResultsDataJSON"

}

class ConverterResultsDataJSON: ConverterResultsDataJSONProtocol  {
    //    MARK: - ConverterResultsDataJSONProtocol methods\
    func createResultsData(json: JSON) throws -> ResultsData {
        // Necessary Attributes
        
        var testName: String
        var testYear: String
        var totalPercentageOfCorrectAnswers: String
        var totalNumberOfQuestions: String
        var totalNumberOfAnsweredQuestions: String
        var totalNumberOfCorrectAnswers: String
        var correctAnswers: String
        var wrongAnswers: String
        var answeredQuestions: String
        var resultsPerTopic: [String : ResultsPerTopic] = [:]
        
        // Parsing
        
        if let name = json["testName"].string {
            testName = name
        } else {
            throw ErrorResultsData.noTestName
        }
        
        if let year = json["testYear"].string {
            testYear = year
        } else {
            throw ErrorResultsData.noYear
        }
        
        if let percentageOfCorrectAnswers = json["totalPercentageOfCorrectAnswers"].string {
            totalPercentageOfCorrectAnswers = percentageOfCorrectAnswers
        } else {
            throw ErrorResultsData.noTotalPercentageOfCorrectAnswers
        }
        
        if let numberOfQuestions = json["totalNumberOfQuestions"].string {
            totalNumberOfQuestions = numberOfQuestions
        } else {
            throw ErrorResultsData.noTotalNumberOfQuestions
        }
        
        if let answeredQuestions = json["totalNumberOfAnsweredQuestions"].string {
            totalNumberOfAnsweredQuestions = answeredQuestions
        } else {
            throw ErrorResultsData.noTotalNumberOfAnsweredQuestions
        }
        
        if let numberOfCorrectAnswers = json["totalNumberOfCorrectAnswers"].string {
            totalNumberOfCorrectAnswers = numberOfCorrectAnswers
        } else {
            throw ErrorResultsData.noTotalNumberOfCorrectAnswers
        }
        
        if let cAnswers = json["correctAnswers"].string {
            correctAnswers = cAnswers
        } else {
            throw ErrorResultsData.noCorrectAnswers
        }
        
        if let wAnswers = json["wrongAnswers"].string {
            wrongAnswers = wAnswers
        } else {
            throw ErrorResultsData.noCorrectAnswers
        }
        
        if let aQuestions = json["answeredQuestions"].string {
            answeredQuestions = aQuestions
        } else {
            throw ErrorResultsData.noCorrectAnswers
        }
        
        if let jsonArray = json["resultsPerTopic"].array {
            if jsonArray.isEmpty { throw ErrorResultsData.arrayResultsPerTopicIsEmpty }
            
            for jsonEntry in jsonArray {
                do {
                    var topic: String
                    var pOfCorrectAnswers: String
                    var numOfQuestions: String
                    var numOfCorrectAnswers: String
                    var totalNumberOfAnsweredQuestions: String
                    
                    if let topicJSON = jsonEntry["topic"].string {
                        topic = topicJSON
                    } else {
                        throw ErrorResultsData.noTopic
                    }
                    
                    if let percentageOfCorrectAnswers = json["totalPercentageOfCorrectAnswers"].string {
                        pOfCorrectAnswers = percentageOfCorrectAnswers
                    } else {
                        throw ErrorResultsData.noTotalPercentageOfCorrectAnswers
                    }
                    
                    if let numberOfQuestions = json["totalNumberOfQuestions"].string {
                        numOfQuestions = numberOfQuestions
                    } else {
                        throw ErrorResultsData.noTotalNumberOfQuestions
                    }
                    
                    if let numberOfCorrectAnswers = json["totalNumberOfCorrectAnswers"].string {
                        numOfCorrectAnswers = numberOfCorrectAnswers
                    } else {
                        throw ErrorResultsData.noTotalNumberOfCorrectAnswers
                    }
                    
                    if let numberOfAnsweredQuestions = json["totalNumberOfAnsweredQuestions"].string {
                        totalNumberOfAnsweredQuestions = numberOfAnsweredQuestions
                    } else {
                        throw ErrorResultsData.noTotalNumberOfAnsweredQuestions
                    }
                    
                    let percentage = (pOfCorrectAnswers as NSString).doubleValue
                    let nOfCorrectAnswers = (numOfCorrectAnswers as NSString).intValue
                    let nOfAnsweredQuestions = (totalNumberOfAnsweredQuestions as NSString).intValue
                    let nOfQuestions = (numOfQuestions as NSString).intValue
                    
                    let resultPerTopic = ResultsPerTopic(totalPercentageOfCorrectAnswers: percentage,
                                                         totalNumberOfCorrectAnswers: Int(nOfCorrectAnswers),
                                                         totalNumberOfAnsweredQuestions: Int(nOfAnsweredQuestions),
                                                         totalNumberOfQuestions: Int(nOfQuestions))
                    
                    resultsPerTopic[topic] = resultPerTopic
                } catch let error as ErrorResult{
                    throw error
                }
            }
        }
        
        // Creating necessary attributes and objects
        let percentage = (totalPercentageOfCorrectAnswers as NSString).doubleValue
        let numRightAnswers = (totalNumberOfCorrectAnswers as NSString).intValue
        let numAnsweredQuestions = (totalNumberOfAnsweredQuestions as NSString).intValue
        let numQuestions = (totalNumberOfQuestions as NSString).intValue
        
        let test = Test(name: testName, year: testYear, questions: [])
        
        let resultsData = ResultsData(totalPercentageOfCorrectAnswers: percentage,
                                      totalNumberOfCorrectAnswers: Int(numRightAnswers),
                                      totalNumberOfAnsweredQuestions: Int(numAnsweredQuestions),
                                      totalNumberOfQuestions: Int(numQuestions),
                                      resultsPerTopic: resultsPerTopic,
                                      test: test,
                                      answeredQuestions: convertStringInADictionary(json: answeredQuestions),
                                      totalTimeElapsed: "",
                                      correctAnswers: convertStringInArrayOfInt(json: correctAnswers),
                                      wrongAnswers: convertStringInArrayOfInt(json: wrongAnswers))
        
        return resultsData
    }
    
    
    /**
    Função responsável por converter um String em um array de Int.

    - parameter json: String a ser transformada para um [Int]
     
     Exemplo: "[1, 2, 3]" -> [1,2,3]

    */
    
    private func convertStringInArrayOfInt(json: String) -> [Int] {
        var numberString = ""
        var array: [Int] = []
        
        for character in json {
            if character == "0" || character == "1" || character == "2" ||
                character == "3" || character == "4" || character == "5" ||
                character == "6" || character == "7" || character == "8" ||
                character == "9" {
                numberString.append(character)
            } else {
                array.append(Int((numberString as NSString).intValue))
                numberString = ""
            }
        }
        
        return array
    }
    
    /**
    Função responsável por converter um String em um dicionário.

    - parameter json: String a ser transformada para um [String:String]
     
     Exemplo: "["20": "B", "10" : "A"]" -> ["20":"B",
                                "10":"A"]

    */
    
    private func convertStringInADictionary(json: String)  -> [String: String] {
        if let data = json.data(using: .utf8) {
            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]{
                    return result
                }
            } catch {
                print("Error in convertStringInADict(json: String)  -> [String: String]  \(error.localizedDescription)")
            }
        }
        
        return ["":""]
    }
}

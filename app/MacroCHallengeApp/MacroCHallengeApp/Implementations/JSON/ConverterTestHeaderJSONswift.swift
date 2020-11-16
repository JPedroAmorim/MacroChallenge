//
//  ConverterTestHeaderJSONswift.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 06/11/20.
//

import Foundation
import SwiftyJSON

class ConverterTestHeaderJSON {
    
    func createSchools(jsonArray: [JSON]) -> [School] {
        var schoolArray: [School] = []
        
        for jsonEntry in jsonArray {
            if let school = createSchool(json: jsonEntry) {
                schoolArray.append(school)
            } else {
                continue
            }
        }
        
        return schoolArray
    }
    
    private func createTestHeader(json: JSON) -> TestHeader? {
        guard let testName = json["testName"].string else {
            return nil
        }
        
        guard let testYear = json["testYear"].string else {
            return nil
        }
        
        guard let numberOfCorrectAnswersForLastResultString = json["numberOfCorrectAnswersForLastResult"].string else {
            return nil
        }
        
        guard let numberOfCorrectAnswersForLastResultInt = Int(numberOfCorrectAnswersForLastResultString) else {
            return nil
        }
        
        guard let totalNumberOfQuestionsForLastResultString = json["totalNumberOfQuestionsForLastResult"].string else {
            return nil
        }
        
        guard let totalNumberOfQuestionsForLastResultInt = Int(totalNumberOfQuestionsForLastResultString) else {
            return nil
        }
        
        return TestHeader(name: testName, year: testYear, numberOfCorrectAnswersForLastResult: numberOfCorrectAnswersForLastResultInt, totalNumberOfOfQuestionsForLastResult: totalNumberOfQuestionsForLastResultInt)
    }
    
    private func createSchool(json: JSON) -> School? {
        guard let schoolName = json["schoolName"].string else {
            return nil
        }
        
        guard let schoolLocation = json["schoolLocation"].string else {
            return nil
        }
        
        guard let schoolLogoUrl = json["schoolLogoUrl"].string else {
            return nil
        }
        
        guard let schoolImage = handleUrlForImages(url: schoolLogoUrl) else {
            return nil
        }
        
        guard let jsonArray = json["tests"].array else {
            return nil
        }
        
        var testHeaders: [TestHeader] = []
        
        for jsonEntry in jsonArray {
            if let testHeader = createTestHeader(json: jsonEntry) {
                testHeaders.append(testHeader)
            } else {
                continue
            }
        }
        
        return School(name: schoolName , location: [schoolLocation], logo: schoolImage, notice: getNotice(schoolName: schoolName), tests: testHeaders)
    }
    
    private func handleUrlForImages(url: String) -> UIImage? {
        if let urlType = URL(string: url) {
            if let imageData = NSData(contentsOf: urlType) {
                if let image = UIImage(data: imageData as Data) {
                    return image
                } else {
                    return nil
                }
            }
        }
        return nil
    }
    
}

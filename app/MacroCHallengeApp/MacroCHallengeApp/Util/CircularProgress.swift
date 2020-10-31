//
//  CircularProgress.swift
//  MacroCHallengeApp
//
//  Created by Rodrigo Takumi on 30/10/20.
//

import Foundation
import KDCircularProgress

class CircularProgress {
    
    var angle: Double = 0
    
    init(numberOfRightQuestions: Int) {
        angle = convertNumberOfRightQuestionsInAngle(numberOfRightQuestions: numberOfRightQuestions)
    }
    
    /**
     
     Método responsável por criar o gráfico circular relativo ao número de acertos de uma prova.
     
     - parameters toAngle: o ângulo relativo ao número de acertos de uma prova.
     
     */
    
    func drawCircularProgress(view: UIView) -> KDCircularProgress {
        let circularProgress: KDCircularProgress = KDCircularProgress(frame: CGRect(x: 0,
                                                                                    y: 0,
                                                                                    width: view.frame.width,
                                                                                    height: view.frame.height))
        
        let colorGreen: UIColor = UIColor(red: 14/255, green: 173/255, blue: 0, alpha: 1)
        let colorGray: UIColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        circularProgress.startAngle = -90
        circularProgress.progressThickness = 0.4
        circularProgress.trackThickness = 0.4
        circularProgress.glowMode = .noGlow
        circularProgress.set(colors: colorGreen)
        circularProgress.trackColor = colorGray
        circularProgress.animate(fromAngle: 0,
                                 toAngle: self.angle,
                                 duration: 0,
                                 completion: nil)
        
        return circularProgress
    }
    
    /**
     
     Método responsável por converter o número de acertos de uma prova para um ângulo.
     
     - parameters numberOfRightQuestions: número de questões acertadas.
     
     */
    
    func convertNumberOfRightQuestionsInAngle(numberOfRightQuestions: Int) -> Double {
        let angle = Double(360*numberOfRightQuestions/50)
        
        return angle
    }
    
}

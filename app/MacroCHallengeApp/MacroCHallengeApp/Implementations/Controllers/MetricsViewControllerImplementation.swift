//
//  MetricsViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 27/10/20.
//

import UIKit
import SwiftyJSON

class MetricsViewControllerImplementation: UIViewController, MetricsViewControllerProtocol {
    // MARK: - Dependencies
    var myView: MetricsViewProtocol?
    var metrics: MetricsProtocol?
    let requestSender = RequestSenderImplementation()
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        getRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Métricas Gerais"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRequest()
    }
    
    // MARK: - Setup methods
    private func setupDefaultMetricsImplementation() {
        self.metrics = MockMetricsImplementation()
    }
    
    private func setupDefaultViewImplementation() {
        if let generalResults = metrics?.getGeneralResults(), let topicsResults = metrics?.getTopicsResults(){
            let defaultView = MetricsViewImplementation(generalResults: generalResults, topicsResults: topicsResults, controller: self)
            self.myView = defaultView
            self.view = defaultView
        }
    }
    
    private func getRequest() {
        
        self.view = LoadingView(message: "Carregando suas métricas ...",
                                error: false)
        requestSender.getAccumulatedResults(completion: {generalResults, topicsResults, err in

            if let general = generalResults, let topics = topicsResults {
                let defaultView = MetricsViewImplementation(generalResults: general, topicsResults: topics, controller: self)
                self.myView = defaultView
                self.view = defaultView
            } else {
                self.view = LoadingView(message: "Falha ao carregar suas métricas :(",
                                        error: true)
            }
            
        })
    }
}

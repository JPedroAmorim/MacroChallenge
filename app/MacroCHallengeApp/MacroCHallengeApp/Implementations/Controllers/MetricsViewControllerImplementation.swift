//
//  MetricsViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 27/10/20.
//

import UIKit
import SwiftyJSON
import AuthenticationServices

class MetricsViewControllerImplementation: UIViewController, MetricsViewControllerProtocol {
    // MARK: - Dependencies
    var myView: MetricsViewProtocol?
    var metrics: MetricsProtocol?
    let requestSender = RequestSenderImplementation()
    
    // MARK: - Variables
    var isLoggedIn = false
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        if isLoggedIn {
            getRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userIsLoggedIn()
        navigationItem.title = "Métricas Gerais"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoggedIn {
            getRequest()
        }
    }
    
    // MARK: - Private Methods
    
    /**
     
     Método responsável verifica se o usuário já logou antes ou não.
     
     - return: true se o usuário está logado, false caso contrário.
     
     */
    private func userIsLoggedIn() {
        if let userIdentifier = UserDefaults.standard.string(forKey: "User") {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    DispatchQueue.main.async {
                        self.getRequest()
                        self.isLoggedIn = true
                    }
                case .revoked, .notFound:
                    DispatchQueue.main.async {
                        self.pushLoginView()
                    }
                default:
                    break
                }
            }
        } else {
            self.pushLoginView()
        }
    }
    
    /**
     
     Método responsável que mostra a tela de login apenas quando o usuário na oestá logado.
     
     */
    
    private func pushLoginView() {
        let controller = LoginViewControllerImplementation(message: "Métricas Gerais")
        if let navController = self.navigationController {
            navController.pushViewController(controller, animated: false)
        }
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

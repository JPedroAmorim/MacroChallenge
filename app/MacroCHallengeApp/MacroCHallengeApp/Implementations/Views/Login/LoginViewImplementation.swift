//
//  LoginViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/11/20.
//

import UIKit
import AuthenticationServices

class LoginViewImplementation: UIView, LoginViewProtocol {
    // MARK: -IBOutlet
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    // MARK: - Dependencies
    var viewController: LoginViewControllerProtocol
    
    // MARK: - Private attributes
    
    
    // MARK: - Init methods
    required init(controller: LoginViewControllerProtocol) {
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib()
        setupProviderLoginView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("LoginViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    // MARK: - Private methods
    
    /**
     
     Método responsável por transformar a StackView em um botão com "Sign in With Apple". O método também relaciona a objc função que faz a request.
     
     */
    
    private func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc
    private func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Extension ASAuthorizationControllerDelegate methods
extension LoginViewImplementation: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // POST para guardar uma nova conta (passa userIdentifier, fullName e email).
            viewController.addNewUser(appleIDCredential)
        
            // pushar próxima view
        
        case let passwordCredential as ASPasswordCredential:
            
            // Sign in using an existing iCloud Keychain credential.
            // GET para fazer requisicao para ver se já existe a conta (passa user e password).
            viewController.checkUserExistence(passwordCredential)

            // 200: existe de fato - > próxima view
            // 404: nao existe -> se cadastre
            
            DispatchQueue.main.async {
                //                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //handle error
    }
}

extension LoginViewImplementation: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let viewControllerAsUIViewController = viewController as? UIViewController else {
            return ASPresentationAnchor()
        }
        
        return viewControllerAsUIViewController.view.window!
    }
}

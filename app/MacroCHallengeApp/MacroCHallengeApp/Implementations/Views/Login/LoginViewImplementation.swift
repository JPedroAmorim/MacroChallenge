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
    @IBOutlet weak var labelMessage: UILabel!
    
    // MARK: - Dependencies
    var viewController: LoginViewControllerProtocol

    // MARK: - Init methods
    required init(message: String, controller: LoginViewControllerProtocol) {
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib(message: message)
        setupProviderLoginView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib(message: String) {
        if let nib = Bundle.main.loadNibNamed("LoginViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
            self.labelMessage.text = message
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
            
            // POST para guardar uma nova conta (passa userIdentifier).
            viewController.addNewUser(appleIDCredential.user)
            
            
            // pushar próxima view
            
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

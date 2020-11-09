//
//  LoginViewControllerImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 06/11/20.
//

import Foundation
import AuthenticationServices

class LoginViewControllerImplementation: UIViewController,  LoginViewControllerProtocol {
    // MARK: - Dependencies
    var myView: LoginViewProtocol?
    let requestSender = RequestSenderImplementation()
    
    // MARK: - Private attributes
    
    
    // MARK: - Lifecycle methods
    required init(controller: LoginViewControllerProtocol) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    
    // MARK: - LoginViewControllerProtocol methods
    func addNewUser(_ account: Account) throws {
        // Criando um usuário criptografado para o Keychain e sua respectiva Query de add
        // https://developer.apple.com/documentation/security/keychain_services/keychain_items/adding_a_password_to_the_keychain
        let user = account.user
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: Credentials.server,
                                    kSecAttrAccount as String: user]
        
        // Adicionando usuário no Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    func checkUserExistence(_ account: Account) {
        
    }
}

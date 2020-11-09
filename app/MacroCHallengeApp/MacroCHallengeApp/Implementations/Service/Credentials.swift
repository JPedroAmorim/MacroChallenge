//
//  Credentials.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 09/11/20.
//

import Foundation

struct Account {
    var user: String
}

enum KeychainError: Error {
    case noUser
    case unexpectedUserData
    case unhandledError(status: OSStatus)
}

class Credentials {
    static let server = "https://macrobd.herokuapp.com/api/v1/"
}

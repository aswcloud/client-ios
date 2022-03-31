//
//  TokenManager.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import Foundation
import SwiftJWT
import AswProtobuf
import GRPC

enum TokenError : Error {
    case tokenFail
    case userAccountFail
}

class TokenManager {
    static let shared = TokenManager()
    
    func create(host: String = "", id: String = "", pw: String = "", _ callback: @escaping (Result<JWT<TokenMessage>, Error>) -> Void) {
        let h = host.ipPort()
        let client = Token.CreateClient(host: h.ip, port: h.port)
        Token.CreateRefreshToken(
            client,
            message: V1_CreateRefreshTokenMessage.with {
                $0.userID = id
                $0.userPassword = pw
            },
            callback: { result in
                switch result {
                case .success(let token):
                    if token.result && token.hasToken {
                        if let jwt = try? JWT<TokenMessage>(jwtString: token.token) {
                            return callback(.success(jwt))
                        }else {
                            return callback(.failure(TokenError.tokenFail))
                        }
                    }else {
                        return callback(.failure(TokenError.userAccountFail))
                    }
                case .failure(let err):
                    return callback(.failure(err))
                }
            })
    }
    
    func refresh(host: String = "", id: String = "", pw: String = "", _ callback: (JWT<TokenMessage>) -> Void) {
        
    }
    
    func get(_ callback: (JWT<TokenMessage>) -> Void) {
        
    }
    
}

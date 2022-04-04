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
    case hostNotFound
}

class TokenManager {
    static let shared = TokenManager()
    private var latestHost = ""
    private var latestId = ""
    private var latestPw = ""
    private var currentRefreshToken: String = ""
    private var currentAccessToken: String = ""
    
    func login(host: String, id: String, pw: String, _ callback: @escaping (Result<JWT<TokenMessage>, Error>) -> Void) {
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
                        self.latestHost = host
                        self.latestId = id
                        self.latestPw = pw
                        self.currentRefreshToken = token.token
                        let jwt = try! JWT<TokenMessage>(jwtString: token.token)
                        self.createAccessToken(message: V1_Uuid.with {
                            $0.uuid = jwt.claims.user_id
                        }) { result in
                            switch result {
                            case .success(let token):
                                callback(.success(try! JWT<TokenMessage>(jwtString: token)))
                                break
                            case .failure(let err):
                                callback(.failure(err))
                                break
                            }
                        }
                    }else {
                        callback(.failure(TokenError.userAccountFail))
                    }
                    break
                case .failure(let err):
                    callback(.failure(err))
                    break
                }
            })
        
    }
    
    func createAccessToken(message: V1_Uuid, _ callback: @escaping (Result<String, Error>) -> Void) {
        if latestHost.isEmpty {
            callback(.failure(TokenError.hostNotFound))
        }
        
        let h = latestHost.ipPort()
        let client = Token.CreateClient(host: h.ip, port: h.port)
        Token.CreateAccessToken(client, message: message, auth: currentRefreshToken) { result in
            switch result {
            case .success(let token):
                if token.result && token.hasToken {
                    self.currentAccessToken = token.token
                    callback(.success(token.token))
                }else {
                    callback(.failure(TokenError.userAccountFail))
                }
                
                break
            case .failure(let err):
                callback(.failure(err))
                break
            }
        }
    }
    
    func updateRefresh(host: String = "", uuid: V1_Uuid, token: String, _ callback: (JWT<TokenMessage>) -> Void) {
        
    }
    
    func getAccessToken(_ callback: @escaping (Result<JWT<TokenMessage>, Error>) -> Void) {
        let jwt = try! JWT<TokenMessage>(jwtString: currentAccessToken)
        switch jwt.validateClaims() {
        case .success:
            return callback(.success(jwt))
        default:
            createAccessToken(message: V1_Uuid.with {
                $0.uuid = jwt.claims.user_id
            }) { result in
                switch result {
                case .success(let token):
                    callback(.success(try! JWT<TokenMessage>(jwtString: token)))
                    break
                default:
                    callback(.failure(TokenError.tokenFail))
                }
            }
            return
        }
    }
    
    func getAccessTokenRaw(_ callback: @escaping (Result<String, Error>) -> Void) {
        let jwt = try! JWT<TokenMessage>(jwtString: currentAccessToken)
        
        switch jwt.validateClaims() {

        case .success:
            return callback(.success(currentAccessToken))
        default:
            createAccessToken(message: V1_Uuid.with {
                $0.uuid = jwt.claims.user_id
            }) { result in
                switch result {
                case .success(let token):
                    callback(.success(token))
                    break
                default:
                    callback(.failure(TokenError.tokenFail))
                }
            }
            return
        }
    }
    
}

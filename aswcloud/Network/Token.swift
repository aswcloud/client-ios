//
//  Token.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/27.
//

import Foundation
import AswProtobuf
import GRPC

class Token {
    
    static func CreateClient(host: String = "", port: Int = 0) -> V1_TokenClient {
        let options = CallOptions(timeLimit: .timeout(Network.shared.timeout))
        return V1_TokenClient(channel: Network.shared.grpcChannel(host: host,
                                                                        port: port)!,
                                    defaultCallOptions: options)
    }
    
    static func CreateRefreshToken(_ client: V1_TokenClient, message: V1_CreateRefreshTokenMessage, callback: @escaping (Result<V1_TokenMessage, Error>) -> Void) {
        let p = client.createRefreshToken(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
}

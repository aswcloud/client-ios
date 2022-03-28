//
//  Register.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/27.
//

import Foundation
import AswProtobuf
import GRPC

class UserAccount {
    static func CreateClient(host: String = "", port: Int = 0) -> V1_UserAccountClient {
        let options = CallOptions(timeLimit: .timeout(Network.shared.timeout))
        return V1_UserAccountClient(channel: Network.shared.grpcChannel(host: host,
                                                                  port: port)!,
                              defaultCallOptions: options)
    }
    
    static func CreateUser(_ client: V1_UserAccountClient, message: V1_MakeUser, callback: @escaping (Result<V1_Result, Error>) -> Void) {
        let p = client.createUser(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    
    
}

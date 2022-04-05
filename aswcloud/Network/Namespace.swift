//
//  Namespace.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/03.
//

import Foundation
import AswProtobuf
import GRPC
import LocalConsole

class Namespace {
    static func CreateClient(host: String = "", port: Int = 0, _ callback: @escaping (Result<V1_KubernetesClient, Error>) -> Void) {
        TokenManager.shared.getAccessTokenRaw { token in
            switch token {
            case .success(let t):
                let options = CallOptions(customMetadata: ["authorization": t], timeLimit: .timeout(Network.shared.timeout))
                callback(.success(V1_KubernetesClient(channel: Network.shared.grpcChannel(host: host,
                                                                                          port: port)!,
                                                      defaultCallOptions: options)))
                break
            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }
    
    static func CreateNamespace(_ client: V1_KubernetesClient, message: V1_namespace, callback: @escaping (Result<V1_Result, Error>) -> Void) {
        let p = client.createNamespace(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    static func ReadNamespace(_ client: V1_KubernetesClient, message: V1_Void, callback: @escaping (Result<V1_list_namespace, Error>) -> Void) {
        let p = client.readNamespace(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    static func DeleteNamespace(_ client: V1_KubernetesClient, message: V1_namespace, callback: @escaping (Result<V1_Result, Error>) -> Void) {
        let p = client.deleteNamespace(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    
    
}

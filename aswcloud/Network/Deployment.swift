//
//  Deployment.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/06.
//

import Foundation
import AswProtobuf
import GRPC

class Deployment {
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
    
    static func CreateDeployment(_ client: V1_KubernetesClient, message: V1_deployment, callback: @escaping (Result<V1_Result, Error>) -> Void) {
        let p = client.createDeployment(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    static func ReadDeployment(_ client: V1_KubernetesClient, message: V1_namespace, callback: @escaping (Result<V1_list_deployment, Error>) -> Void) {
        let p = client.readDeployment(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }
    static func DeleteDeployment(_ client: V1_KubernetesClient, message: V1_delete_deployment, callback: @escaping (Result<V1_Result, Error>) -> Void) {
        let p = client.deleteDeployment(message)
        
        p.response.whenComplete { result in
            callback(result)
        }
        
        _ = p.status.always { result in
            print(result)
        }
    }

}

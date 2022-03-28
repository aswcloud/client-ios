//
//  Network.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/27.
//

import Foundation
import NIO
import GRPC

enum NetworkError : Error {
    case poolCreateFail
}

class Network {
    static let shared = Network()
    
    let eventLoopGroup: EventLoopGroup
    
    private var currentEndPoint: (host: String, port: Int) = ("", 0)
    private var currentGrpcChannel: GRPCChannel?
    
    public private(set) var timeout: TimeAmount = .seconds(1)
    
    // 솔직히 죽으면 그건 그것대로 곤란함.
    func grpcChannel(host: String = "", port: Int = 0) -> GRPCChannel? {
        if (host == "" && port == 0) ||
            (currentEndPoint.host == host && currentEndPoint.port == port) {
            return currentGrpcChannel
        }else {
            _ = currentGrpcChannel?.close().always { _ in
//                print($0)
            }
            currentEndPoint = (host, port)
            currentGrpcChannel = try? GRPCChannelPool.with(target: .hostAndPort(host, port),
                                                           transportSecurity: .plaintext,
                                                           eventLoopGroup: eventLoopGroup)
           
            return currentGrpcChannel
        }
    }
    
    init() {
        eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    }
    
    deinit {
        try? eventLoopGroup.syncShutdownGracefully()
    }
    
}

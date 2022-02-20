//
//  LoginViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import Foundation
import SwiftUI
import AswProtobuf
import GRPC
import AlertToast


class LoginViewModel : ObservableObject {
    // MARK: - Published Object
    @Published var autoLogin = false
    @Published var toastLoginResult = false
    
    public private(set) var currentLoginResult: LoginResult? = nil
    
    // MARK: - Result Type Enum
    enum LoginFail : String {
        case networkFailure = "인터넷 연결이 되어 있지 않습니다."
        case notMatching = "일치하는 계정이 없습니다."
    }
    
    enum LoginResult {
        case success(String, String)
        case fail(LoginFail)
    }
    
    
    // MARK: - View to ViewModel Event
    
    func login(ip: String, id: String, pw: String) {
        // Login PoC 검증 코드
        // TODO:
        // 추후 LoginSession 에 통합 되어서 코드 간략화가 될 예정
        
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer {
            try? group.syncShutdownGracefully()
        }
        
        let split = ip.split(separator: ":")
        let host: String
        let port: Int
        
        if ip.isEmpty {
            host = "localhost"
            port = 8088
        }
        else if split.count == 1 {
            host = String(split[0])
            port = 8088
        }else {
            host = String(split[0])
            if let num = Int(split[1]) {
                port = num
            }else {
                port = 8088
            }
        }
        
        guard let pool = try? GRPCChannelPool.with(target: .host(host, port: port),
                                                   transportSecurity: .plaintext,
                                                   eventLoopGroup: group) else {
            currentLoginResult = .fail(.networkFailure)
            toastLoginResult = true
            return
        }
        
        let client = AswProtobuf.V1_TokenClient(channel: pool)
        defer {
            try? client.channel.close().wait()
        }
        
        let send = V1_UserLoginMessage.with {
            $0.userID = id
            $0.userPassword = pw
            $0.role = []
        }
        
        let p = client.createRefreshToken(send)
        
        if let result = try? p.response.wait() {
            if result.result {
                currentLoginResult = .success(result.uuid.uuid, result.token)
            }else {
                currentLoginResult = .fail(.notMatching)
            }
        }else {
            currentLoginResult = .fail(.networkFailure)
        }
        toastLoginResult = true
    }
    
    func getAlertToast() -> AlertToast {
        if let login = currentLoginResult {
            switch login {
            case .success(let uuid, let token):
                return AlertToast(displayMode: .hud, type: .regular, title: uuid, subTitle: token)
                
            case .fail(let reason):
                return AlertToast(displayMode: .hud, type: .regular, title: "로그인 실패 하였습니다.", subTitle: reason.rawValue)
            }
        }else {
            return AlertToast(displayMode: .hud, type: .regular, title: "알수없는 오류 발생함.")
        }
    }
    
}

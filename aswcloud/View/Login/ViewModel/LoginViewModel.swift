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
import SwiftJWT


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
    
    func login(data: LoginResultModel) {
        // Login PoC 검증 코드
        // TODO:
        // 추후 LoginSession 에 통합 되어서 코드 간략화가 될 예정
        
        let endPoint = data.serverIp.ipPort()
        
        let client = Token.CreateClient(host: endPoint.ip, port: endPoint.port)
        
        let send = V1_CreateRefreshTokenMessage.with {
            $0.userID = data.userId
            $0.userPassword = data.userPassword
        }
        
        Token.CreateRefreshToken(client, message: send) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    if token.result {
                        let tokenMessage = try! JWT<TokenMessage>.init(jwtString: token.token)
                        self.currentLoginResult = .success(tokenMessage.claims.user_id, token.token)
                    }else {
                        self.currentLoginResult = .fail(.notMatching)
                    }
                    break
                case .failure(_):
                    self.currentLoginResult = .fail(.networkFailure)
                    break
                }
                self.toastLoginResult = true
            }
        }
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

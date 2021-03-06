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
    
    public private(set) var currentLoginResult: LoginResult? = nil
    
    // MARK: - Result Type Enum
    enum LoginFail : String {
        case networkFailure = "인터넷 연결이 되어 있지 않습니다."
        case notMatching = "일치하는 계정이 없습니다."
    }
    
    enum LoginResult {
        case success(String)
        case fail(LoginFail)
    }
    
    var alertToast: (AlertToast) -> Void = { _ in }
    
    var loginSucces: (LoginResultModel) -> Void = { _ in }
    
    // MARK: - View to ViewModel Event
    func login(data: LoginResultModel) {
        // Login PoC 검증 코드
        // TODO:
        // 추후 LoginSession 에 통합 되어서 코드 간략화가 될 예정
        
        TokenManager.shared.login(host: data.serverIp, id: data.userId, pw: data.userPassword) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.currentLoginResult = .success(token.claims.name!)
                    self.loginSucces(data)
                    break
                case .failure(_):
                    self.currentLoginResult = .fail(.networkFailure)
                    break
                }
                self.alertToast(self.getAlertToast())
            }
        }
    }
    
    func getAlertToast() -> AlertToast {
        if let login = currentLoginResult {
            switch login {
            case .success(let uuid):
                return AlertToast(displayMode: .hud, type: .regular, title: "로그인에 성공적으로 하였습니다.", subTitle: "\"\(uuid)\" 환영 합니다.")
                
            case .fail(let reason):
                return AlertToast(displayMode: .hud, type: .regular, title: "로그인 실패 하였습니다.", subTitle: reason.rawValue)
            }
        }else {
            return AlertToast(displayMode: .hud, type: .regular, title: "알수없는 오류 발생함.")
        }
    }
    
}

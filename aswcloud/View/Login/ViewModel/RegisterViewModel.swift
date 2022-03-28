//
//  RegisterViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/22.
//

import Foundation
import SwiftUI
import AswProtobuf
import GRPC
import AlertToast
import NIO

class RegisterViewModel : ObservableObject {
    @Published var register = RegisterModel(serverIp: "",
                                            registerToken: "",
                                            userId: "",
                                            password: "",
                                            confirmPassword: "",
                                            nickName: "",
                                            email: "")
     
    @Published var toastRegisterResult = false
    public private(set) var currentRegisterResult: RegisterResult? = nil
    
    
    enum RegisterResult {
        case success(String, String)
        case fail(String)
    }
    
    
    func registerRequest() {
        if register.password != register.confirmPassword {
            currentRegisterResult = .fail("확인 비밀번호가 같지 않습니다.")
            toastRegisterResult = true
            return
        }else if register.nickName.isEmpty {
            currentRegisterResult = .fail("닉네임이 공란이 될 수 없습니다.")
            toastRegisterResult = true
            return
        }

        let endPoint = register.serverIp.ipPort()
        
        let client = UserAccount.CreateClient(host: endPoint.ip, port: endPoint.port)
        
        let send = V1_MakeUser.with {
            $0.user = V1_User.with {
                $0.userID = register.userId
                $0.userEmail = register.email
                $0.userNickname = register.nickName
                $0.userPassword = String(register.password.sha256())
            }
            $0.token = register.registerToken
        }
        
        UserAccount.CreateUser(client, message: send) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    if token.result {
                        self.currentRegisterResult = .success(self.register.userId,
                                                              self.register.password)
                    }else {
                        self.currentRegisterResult = .fail(token.error)
                    }
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.currentRegisterResult = .fail("인터넷 연결이 되어 있지 않습니다.")
                    break
                }
                self.toastRegisterResult = true
            }
        }
    }
    
    
    func getAlertToast() -> AlertToast {
        if let login = currentRegisterResult {
            switch login {
            case .success(_, _):
                return AlertToast(displayMode: .hud, type: .regular, title: "회원가입에 성공했습니다!")
                
            case .fail(let reason):
                if reason.contains("exists") {
                    return AlertToast(displayMode: .hud, type: .regular, title: "회원가입에 실패 하였습니다.", subTitle: "이미 아이디가 존재 합니다.")
                }else if reason.contains("document"){
                    return AlertToast(displayMode: .hud, type: .regular, title: "회원가입에 실패 하였습니다.", subTitle: "회원 가입 토큰 값이 잘못 입력 되었습니다.")
                }else {
                    return AlertToast(displayMode: .hud, type: .regular, title: "회원가입에 실패 하였습니다.", subTitle: reason)
                }
                
            }
        }else {
            return AlertToast(displayMode: .hud, type: .regular, title: "알수없는 오류 발생함.")
        }
    }
    
}

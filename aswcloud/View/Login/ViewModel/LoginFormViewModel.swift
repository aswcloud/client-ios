//
//  LoginFormViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import Foundation
import SwiftUI


class LoginFormViewModel : ObservableObject {
    // MARK: - Published Object
    @Published var serverIp = "127.0.0.1:8088"
    @Published var userId = "Test"
    @Published var userPassword = "test"
    
    // MARK: - View to ViewModel Event
    
    func getUserAccount() -> LoginResultModel {
        
        return .init(serverIp: serverIp, userId: userId, userPassword: String(userPassword.sha256()))
    }
    
    // MARK: - 기본 아이디, 비밀번호 설정 할 때 이곳에서 초기화 함.
    init() {
        
    }
    
}

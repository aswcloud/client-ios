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
    @Published var serverIp = ""
    @Published var userId = ""
    @Published var userPassword = ""
    
    // MARK: - View to ViewModel Event
    
    func getUserAccount() -> LoginResultModel {
        
        return .init(serverIp: serverIp, userId: userId, userPassword: userPassword)
    }
    
    // MARK: - 기본 아이디, 비밀번호 설정 할 때 이곳에서 초기화 함.
    init() {
        
    }
    
}

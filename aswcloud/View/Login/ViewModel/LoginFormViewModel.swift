//
//  LoginFormViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import Foundation
import SwiftUI
import CryptoKit

class LoginFormViewModel : ObservableObject {
    // MARK: - Published Object
    @Published var serverIp = ""
    @Published var userId = ""
    @Published var userPassword = ""
    
    // MARK: - View to ViewModel Event
    
    func getUserAccount() -> (String, String, String) {
        let hash = SHA256.hash(data: userPassword.data(using: .utf8)!)
        let text = hash.compactMap{ String(format: "%02x", $0) }.joined()
        return (serverIp, userId, text)
    }
    
    // MARK: - 기본 아이디, 비밀번호 설정 할 때 이곳에서 초기화 함.
    init() {
        
    }
    
}

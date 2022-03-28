//
//  RegisterServerView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/28.
//

import SwiftUI
import BetterSafariView

struct RegisterServerView: View {
    @State var helpRegisterToken = false
    @Binding var serverIp: String
    @Binding var registerToken: String
    
    var body: some View {
        Section("Server Information") {
            TextField("서버 주소", text: $serverIp)
                .textContentType(.URL)
                .keyboardType(.URL)
            TextField("회원가입 토큰", text: $registerToken)
                .keyboardType(.asciiCapable)
            Button("회원가입 토큰이란?") {
                // TODO: github markdown 페이지로 이동
                helpRegisterToken = true
            }.safariView(isPresented: $helpRegisterToken) {
                SafariView(url: URL(string: "https://github.com/aswcloud/document/blob/main/ios-register-token.md#%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85-%ED%86%A0%ED%81%B0%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80%EC%9A%94")!)
            }
        }
    }
}

struct RegisterServerView_Previews: PreviewProvider {
    @State static var ip = ""
    @State static  var token = ""
    static var previews: some View {
        RegisterServerView(serverIp: $ip, registerToken: $token)
    }
}

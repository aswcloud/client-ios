//
//  LoginFormView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import SwiftUI

struct LoginFormView: View {
    @StateObject var viewModel = LoginFormViewModel()
    
    var login: (LoginResultModel) -> Void = { _ in }
    func onLogin(login: @escaping (LoginResultModel) -> Void) -> LoginFormView {
        var p = self
        p.login = login
        return p
    }
    
    var body: some View {
        VStack {
            GroupBox("로그인") {
                Group {
                    TextField("Server IP", text: $viewModel.serverIp)
                    TextField("User Id", text: $viewModel.userId)
                    SecureField("Password", text: $viewModel.userPassword)
                }
            }
            
            Button(action: {
                login(viewModel.getUserAccount())
            }) {
                Text("로그인")
            }
            .buttonStyle(BorderedButtonStyle())
            .frame(maxWidth: .infinity)
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    @State static var ip = "127.0.0.1:8080"
    @State static var id = "testuserid"
    @State static var pw = "testpassword"
    
    static var previews: some View {
        LoginFormView()
    }
}

//
//  LoginView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import AlertToast

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                LoginFormView()
                    .onLogin(login: viewModel.login)
                    .toast(isPresenting: $viewModel.toastLoginResult) {
                        viewModel.getAlertToast()
                    }
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        NavigationLink(destination: RegisterView()) {
                            Text("회원가입")
                        }
                        
                        LoginAutoLoginView(autoLogin: $viewModel.autoLogin)
                    }
                }
            }.padding()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

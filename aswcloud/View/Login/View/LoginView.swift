//
//  LoginView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import AlertToast
import SwiftJWT

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    @State var showRegister = false
    
    func onLogin(_ callback: @escaping (LoginResultModel) -> Void) -> LoginView {
        let view = self
        view.viewModel.loginSucces = callback
        return view
    }
    
    func onAlertToast(_ callback: @escaping (AlertToast) -> Void) -> LoginView {
        let view = self
        view.viewModel.alertToast = callback
        return view
    }
    
    var body: some View {
        NavigationView {
            VStack {
                LoginFormView()
                    .onLogin(login: viewModel.login)
                    
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        NavigationLink(destination: RegisterView().onRegister { _ in
                            showRegister = false
                        }.onAlertToast(viewModel.alertToast), isActive: $showRegister) {
                            Text("회원가입")
                        }
                        LoginAutoLoginView(autoLogin: $viewModel.autoLogin)
                    }
                }
            }.padding()
        }
//        .toast(isPresenting: $viewModel.toastLoginResult) {
//            viewModel.getAlertToast()
//        }
        .navigationViewStyle(.stack)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

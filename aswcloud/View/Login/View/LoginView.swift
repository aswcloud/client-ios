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
                    .onLogin { ip, id, pw in
                        viewModel.text = "\(ip)\n\(id)\n\(pw)"
                        viewModel.autoLogin.toggle()
                    }.toast(isPresenting: $viewModel.autoLogin) {
                        AlertToast(displayMode: .hud, type: .regular, title: viewModel.text)
                    }
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        NavigationLink(destination: EmptyView()
                                        .navigationBarBackButtonHidden(true)) {
                            Text("회원가입")
                        }
                        
                        Button(action: {
                            viewModel.autoLogin.toggle()
                        }) {
                            HStack {
                                if viewModel.autoLogin {
                                    Image(systemName: "chevron.down.square")
                                        .foregroundColor(Color.red)
                                }else {
                                    Image(systemName: "chevron.down.square.fill")
                                        .foregroundColor(Color.red)
                                }
                                Text("자동 로그인")
                            }.foregroundColor(Color.primary)
                        }
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

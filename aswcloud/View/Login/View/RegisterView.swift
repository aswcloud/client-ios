//
//  RegisterView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import SwiftUI
import BetterSafariView


struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var helpRegisterToken = false
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    
    var body: some View {
        VStack {
            HStack {
                btnBack
                Spacer()
            }
            .padding([.leading, .trailing])
            
            List {
                Section("Server Information") {
                    TextField("서버 주소", text: $viewModel.register.serverIp)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                    TextField("회원가입 토큰", text: $viewModel.register.registerToken)
                        .keyboardType(.asciiCapable)
                    Button("회원가입 토큰이란?") {
                        // TODO: github markdown 페이지로 이동
                        helpRegisterToken = true
                    }.safariView(isPresented: $helpRegisterToken) {
                        SafariView(url: URL(string: "https://github.com/aswcloud/document/blob/main/ios-register-token.md#%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85-%ED%86%A0%ED%81%B0%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80%EC%9A%94")!)
                    }
                }
                Section("User Information") {
                    TextField("아이디", text: $viewModel.register.userId)
                        .textContentType(.username)
                    SecureField("비밀번호", text: $viewModel.register.password)
                        .textContentType(.password)
                    SecureField("확인 비밀번호", text: $viewModel.register.confirmPassword)
                        .textContentType(.password)
                    TextField("닉네임", text: $viewModel.register.nickName)
                        .textContentType(.name)
                    TextField("(선택) 이메일 주소", text: $viewModel.register.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                }
                
                // TODO: send view model and server
                Button("회원가입", action: viewModel.registerRequest)
            }
        }
        .toast(isPresenting: $viewModel.toastRegisterResult) {
            viewModel.getAlertToast()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if (value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }))
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

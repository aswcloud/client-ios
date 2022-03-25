//
//  RegisterView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import SwiftUI


struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
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
            }.padding([.leading, .trailing])
            
            List {
                Section("Server Information") {
                    TextField("서버 주소", text: $viewModel.register.serverIp)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                    TextField("회원가입 토큰", text: $viewModel.register.registerToken)
                        .keyboardType(.asciiCapable)
//                    NavigationLink("회원가입 토큰이란?") {
//                        WebView
//                    }
                    Button("회원가입 토큰이란?") {
                        // TODO: github markdown 페이지로 이동
                        
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
                Button("회원가입") {
                    // TODO: send view model and server
                }
            }
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

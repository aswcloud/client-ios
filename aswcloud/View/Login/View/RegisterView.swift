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
                RegisterServerView(serverIp: $viewModel.register.serverIp,
                                   registerToken: $viewModel.register.registerToken)
                
                RegisterUserView(userId: $viewModel.register.userId,
                                 password: $viewModel.register.password,
                                 confirmPassword: $viewModel.register.confirmPassword,
                                 nickName: $viewModel.register.nickName,
                                 email: $viewModel.register.email)
                
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

//
//  RegisterUserView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/28.
//

import SwiftUI

struct RegisterUserView: View {
    @Binding var userId: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var nickName: String
    @Binding var email: String
    
    
    var body: some View {
        Section("User Information") {
            TextField("아이디", text: $userId)
                .textContentType(.username)
            SecureField("비밀번호", text: $password)
                .textContentType(.password)
            SecureField("확인 비밀번호", text: $confirmPassword)
                .textContentType(.password)
            TextField("닉네임", text: $nickName)
                .textContentType(.name)
            TextField("(선택) 이메일 주소", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
        }
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    @State static var id = ""
    @State static  var pass = ""
    @State static var cpass = ""
    @State static  var nick = ""
    @State static var email = ""
    
    static var previews: some View {
        RegisterUserView(userId: $id, password: $pass, confirmPassword: $cpass, nickName: $nick, email: $email)
    }
}

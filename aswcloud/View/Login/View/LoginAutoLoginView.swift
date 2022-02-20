//
//  LoginAutoLoginView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import SwiftUI

struct LoginAutoLoginView: View {
    @Binding var autoLogin: Bool
    
    
    var body: some View {
        Button(action: {
            autoLogin.toggle()
        }) {
            HStack {
                if autoLogin {
                    Image(systemName: "chevron.down.square.fill")
                        .foregroundColor(Color.red)
                }else {
                    Image(systemName: "chevron.down.square")
                        .foregroundColor(Color.red)
                }
                Text("자동 로그인")
            }.foregroundColor(Color.primary)
        }
    }
}

struct LoginAutoLoginView_Previews: PreviewProvider {
    @State static var autoLogin = false
    
    static var previews: some View {
        LoginAutoLoginView(autoLogin: $autoLogin)
    }
}

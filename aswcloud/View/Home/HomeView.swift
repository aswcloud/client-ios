//
//  HomeView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import SwiftJWT

struct HomeView: View {
    @Binding var loginResult: LoginResultModel!
    @Binding var loginToken: JWT<TokenMessage>!
    
    var body: some View {
        TabView {
            UserView().tabItem {
                Text("사용자")
            }
            OrganizationView().tabItem {
                Text("그룹")
            }
            Group {
                Button(action: {
                    withAnimation {
                        loginToken = nil
                    }
                }) {
                    Text("AAA")
                }
            }.tabItem {
                Text("계정")
            }
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var p: LoginResultModel? = .init(serverIp: "", userId: "", userPassword: "")
    @State static var t: JWT<TokenMessage>? = .init(claims: TokenMessage(iat: 0, exp: 0, user_id: "", authorized: true))
    
    static var previews: some View {
        HomeView(loginResult: $p, loginToken: $t)
    }
}

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
//    @Binding var loginToken: String!
    
    
    
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
                        loginResult = nil
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

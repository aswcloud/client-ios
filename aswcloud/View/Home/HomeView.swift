//
//  HomeView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import SwiftJWT

struct HomeView: View {
    @State var loginResult: LoginResultModel? = nil
    @State var loginToken: JWT<TokenMessage>? = nil
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

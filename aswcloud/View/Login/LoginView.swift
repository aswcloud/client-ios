//
//  LoginView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI

struct LoginView: View {
    @State private var serverIp = ""
    
    private var login: ()
    
    var body: some View {
        VStack {
            Text("ASW Cloud")
            TextField("Server IP", text: $serverIp)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

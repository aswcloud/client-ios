//
//  EntryPointView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI

struct EntryPointView: View {
    @State var isLogin = false
    @State var isLoading = false
    
    var body: some View {
        if isLogin {
            HomeView()
        }else {
            LoginView()
        }
    }
}

struct EntryPointView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPointView()
    }
}

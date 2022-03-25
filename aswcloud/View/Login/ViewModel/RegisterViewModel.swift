//
//  RegisterViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/22.
//

import Foundation
import SwiftUI

class RegisterViewModel : ObservableObject {
    @Published var register = RegisterModel(serverIp: "", registerToken: "", userId: "", password: "", confirmPassword: "", nickName: "", email: "")
     
    
}

//
//  LoginViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/20.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject {
    @Published var autoLogin = false
    
    var text: String = ""
}

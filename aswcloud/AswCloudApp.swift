//
//  aswcloudApp.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import LocalConsole

@main
struct AswCloudApp: App {
    var body: some Scene {
        WindowGroup {
            EntryPointView().onAppear {
                LCManager.shared.isVisible = true
            }
        }
    }
}

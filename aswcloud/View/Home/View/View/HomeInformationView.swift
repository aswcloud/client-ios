//
//  HomeInformationView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/06.
//

import SwiftUI

struct HomeInformationView: View {
    @Binding var namespaceCount: Int
    @Binding var deploymentCount: Int
    
    
    var body: some View {
        Section("정보") {
            Text("Namespace : \(namespaceCount) 개")
            HStack {
                Text("Deployment : \(deploymentCount)개")
                Spacer()
                Text("Pods : 5개")
            }
            Text("Service : 5개")
            HStack {
                Text("Storage : 3개")
                Spacer()
                Text("33 GB / 33 GB")
            }
        }
    }
}

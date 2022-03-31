//
//  UserView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI

struct UserView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section("정보") {
                    Text("Namespace : 5개")
                    HStack {
                        Text("Deployment : 5개")
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
                
                Section("Namespace") {
                    NavigationLink(destination: {
                        NamespaceView()
                    }) {
                        Text("이동")
                    }
                }
                Section("Deployment") {
                    NavigationLink(destination: {
                        DeploymentView()
                    }) {
                        Text("이동")
                    }
                }
                Section("Pods") {
                    NavigationLink(destination: {
                        PodView()
                    }) {
                        Text("이동")
                    }
                }
                Section("Service") {
                    NavigationLink(destination: {
                        ServiceView()
                    }) {
                        Text("이동")
                    }
                }
                Section("Storage") {
                    NavigationLink(destination: {
                        StorageView()
                    }) {
                        Text("이동")
                    }
                }
            }
            .navigationTitle("리소스 관리")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

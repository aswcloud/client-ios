//
//  UserView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    
    var body: some View {
        NavigationView {
            Form {
                HomeInformationView(namespaceCount: $viewModel.namespaceCount)
                
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
        .onAppear(perform: viewModel.load)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

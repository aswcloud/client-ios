//
//  DeploymentView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI

struct DeploymentView: View {
    @ObservedObject var viewModel = DeploymentViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.namespace) { namespace in
                Section("Namespace : \(namespace.title)") {
                    ForEach(namespace.deployment) { deploy in
                        Text("\(deploy.title)")
                    }
                    
                }
            }
        }
        .onAppear(perform: viewModel.load)
        .navigationTitle("Namespace")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("New") {
//                createInput = .medium
            }
        }
    }
}

struct DeploymentView_Previews: PreviewProvider {
    static var previews: some View {
        DeploymentView()
    }
}

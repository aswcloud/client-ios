//
//  UserViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/06.
//

import Foundation
import SwiftUI
import AswProtobuf

class UserViewModel : ObservableObject {
    @Published var namespaceCount = 0
    @Published var deploymentCount = 0
    func load() {
        Namespace.CreateClient { c in
            switch c {
            case .success(let client):
                Namespace.ReadNamespace(client, message: V1_Void.with { _ in }) { r in
                    switch r {
                    case .success(let list):
                        DispatchQueue.main.async {
                            self.namespaceCount = list.list.count
                        }
                        
                        for item in list.list {
                            Deployment.ReadDeployment(client, message: item) { r in
                                switch r {
                                case .success(let deployment):
                                    DispatchQueue.main.async {
                                        self.deploymentCount += deployment.list.count
                                    }
                                    break
                                case .failure(_):
                                    break
                                }
                            }
                        }
                        break
                    case .failure(_):
                        break
                    }
                }
                
            default:
                break
            }
        }
    }
    
}

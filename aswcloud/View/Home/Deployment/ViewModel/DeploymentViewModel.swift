//
//  DeploymentViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/06.
//

import SwiftUI
import AswProtobuf


struct DeploymentModel : Identifiable {
    let id = UUID()
    var title: String
    
    var deployment: [DeploymentTitleModel]
}
struct DeploymentTitleModel : Identifiable {
    let id = UUID()
    var title: String
}


class DeploymentViewModel : ObservableObject {
    @Published var namespace = [DeploymentModel]()
    
    
    func load() {
        namespace.removeAll()
        
        Namespace.CreateClient { c in
            switch c {
            case .success(let client):
                Namespace.ReadNamespace(client, message: V1_Void.with { _ in }) { r in
                    switch r {
                    case .success(let list):
                        for item in list.list {
                            Deployment.ReadDeployment(client, message: item) { r in
                                switch r {
                                case .success(let deployment):
                                    DispatchQueue.main.async {
                                        self.namespace.append(.init(title: item.name, deployment: deployment.list.map {
                                            DeploymentTitleModel(title: $0.name == "" ? "all" : $0.name)
                                        }))
                                    }
                                    break
                                case .failure(_):
                                    break
                                }
                            }
                        }
                        break
                    default:
                        break
                    }
                }
                
            default:
                break
            }
        }
    }
    
}

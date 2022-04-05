//
//  NamespaceViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/04.
//

import Foundation
import SwiftUI
import AswProtobuf



class NamespaceViewModel : ObservableObject {
    @Published var namespace = [NamespaceModel]()
    @Published var input = ""
    
    func delete(indexSet: IndexSet) {
        Namespace.CreateClient { c in
            switch c {
            case .success(let client):
                let n = self.namespace
                indexSet.forEach { index in
                    Namespace.DeleteNamespace(client, message: V1_namespace.with {
                        $0.name = n[index].title
                    }) { _ in }
                }
                DispatchQueue.main.async {
                    self.namespace.remove(atOffsets: indexSet)
                }
            default:
                break
            }
        }
    }
    
    func load() {
        Namespace.CreateClient { c in
            switch c {
            case .success(let client):
                Namespace.ReadNamespace(client, message: V1_Void.with { _ in }) { r in
                    switch r {
                    case .success(let list):
                        DispatchQueue.main.async {
                            self.namespace = list.list.map { NamespaceModel(title: $0.name) }
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
    
    func create(title: String) {
        Namespace.CreateClient { c in
            switch c {
            case .success(let client):
                Namespace.CreateNamespace(client, message: V1_namespace.with {
                    $0.name = title
                }) { data in
                    switch data {
                    case .success(_):
                        self.load()
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

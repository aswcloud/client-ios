//
//  NamespaceView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI
import AswProtobuf

struct NamespaceView: View {
    @State var test = [String]()
    
    var body: some View {
        List {
            Section("TEST") {
                Button("Create") {
                    Namespace.CreateClient { c in
                        switch c {
                        case .success(let client):
                            Namespace.CreateNamespace(client, message: V1_namespace.with {
                                $0.name = "helloworld"
                            }) { _ in
                                Namespace.ReadNamespace(client, message: V1_Void.with { _ in }) { r in
                                    switch r {
                                    case .success(let list):
                                        test = list.list.map { $0.name }
                                        break
                                    case .failure(_):
                                        break
                                    }
                                }
                            }
                        default:
                            break
                        }
                    }
                }
                Button("Delete") {
                    Namespace.CreateClient { c in
                        switch c {
                        case .success(let client):
                            Namespace.DeleteNamespace(client, message: V1_namespace.with {
                                $0.name = "helloworld"
                            }) { _ in
                                Namespace.ReadNamespace(client, message: V1_Void.with { _ in }) { r in
                                    switch r {
                                    case .success(let list):
                                        test = list.list.map { $0.name }
                                        break
                                    case .failure(_):
                                        break
                                    }
                                }
                            }
                        default:
                            break
                        }
                    }
                }
            }
            Section("Namespace") {
                ForEach(test, id: \.self) { data in
                    Text("\(data)")
                }
            }
        }.onAppear {
           
        }
    }
}

struct NamespaceView_Previews: PreviewProvider {
    static var previews: some View {
        NamespaceView()
    }
}

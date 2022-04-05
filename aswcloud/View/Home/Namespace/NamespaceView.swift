//
//  NamespaceView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI
import AswProtobuf
import ResizableSheet

struct NamespaceView: View {
    @ObservedObject var viewModel = NamespaceViewModel()
    @State var createInput = ResizableSheetState.hidden
    @State var createInputText = ""
    
    var body: some View {
        List {
            Section("Namespace") {
                ForEach(viewModel.namespace) { data in
                    Text("\(data.title)")
                }
                .onDelete(perform: viewModel.delete)
            }
        }
        .resizableSheet($createInput) { builder in
            builder.content { _ in
                Group {
                    Text("Create Namespace")
                    Divider()
                    HStack {
                        Text("Title : ")
                        TextField("Namespace Title", text: $createInputText)
                            .textInputAutocapitalization(.never)
                    }.KeyboardAwarePadding()
                    Spacer()
                    Button("Create", action: {
                        viewModel.create(title: createInputText)
                        createInputText = ""
                        createInput = .hidden
                    }).padding()
                }
                .padding()
            }
        }
        .onChange(of: createInput) { data in
            if data == .hidden {
                createInputText = ""
                UIApplication.shared.endEditing()
            }
        }
        .navigationTitle("Namespace")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.load)
        .toolbar {
            Button("New") {
                createInput = .medium
            }
        }
        
    }
}

struct NamespaceView_Previews: PreviewProvider {
    static var previews: some View {
        NamespaceView()
    }
}

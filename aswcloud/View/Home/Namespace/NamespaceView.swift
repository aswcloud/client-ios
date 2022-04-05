//
//  NamespaceView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/03/31.
//

import SwiftUI
import AswProtobuf

struct NamespaceView: View {
    @ObservedObject var viewModel = NamespaceViewModel()
    @State var createInput = false
    @State var createInputText = ""
    
    var body: some View {
        List {
            Section("Management") {
                Button("New") {
                    withAnimation {
                        createInput.toggle()
                    }
                }
                if createInput {
                    Group {
                        TextField("Namespace Title", text: $createInputText)
                        Button("Create", action: {
                            viewModel.create(title: createInputText)
                            createInputText = ""
                        })
                    }
                }
            }
            Section("Namespace") {
                ForEach(viewModel.namespace) { data in
                    Text("\(data.title)")
                }
                .onDelete(perform: viewModel.delete)
            }
        }
        .onAppear(perform: viewModel.load)
        .toolbar {
            EditButton()
        }
    }
}

struct NamespaceView_Previews: PreviewProvider {
    static var previews: some View {
        NamespaceView()
    }
}

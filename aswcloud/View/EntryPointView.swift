//
//  EntryPointView.swift
//  aswcloud
//
//  Created by ChaCha on 2022/02/08.
//

import SwiftUI
import SwiftJWT
import AlertToast

class EntryPointViewModel : ObservableObject {
    @Published var loginResult: LoginResultModel? = nil
    @Published var toastUi: Bool = false
    
    var currentToast: AlertToast = .init(displayMode: .hud, type: .loading)
    func getToast() -> AlertToast {
        return .init(displayMode: currentToast.displayMode,
                     type: currentToast.type,
                     title: currentToast.title,
                     subTitle: currentToast.subTitle)
    }
    
    
    func setLogin(data: LoginResultModel) {
        self.loginResult = data
    }
}

struct EntryPointView: View {
    @ObservedObject var viewModel = EntryPointViewModel()
    
    var body: some View {
        Group {
            if viewModel.loginResult != nil {
                HomeView(loginResult: $viewModel.loginResult)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }else {
                LoginView().onLogin { data in
                    withAnimation {
                        viewModel.setLogin(data: data)
                    }
                }.onAlertToast {
                    viewModel.currentToast = $0
                    viewModel.toastUi = true
                }
            }
        }.toast(isPresenting: $viewModel.toastUi, alert: { viewModel.getToast() })
            
        
    }
}

struct EntryPointView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPointView()
    }
}

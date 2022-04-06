//
//  DeploymentViewModel.swift
//  aswcloud
//
//  Created by ChaCha on 2022/04/06.
//

import SwiftUI

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
    
}

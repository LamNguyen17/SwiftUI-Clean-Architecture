//
//  Photo_MVVMApp.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import SwiftUI

@main
struct Photo_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoListView()
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            PhotoRepository() as PhotoUseCase
        }
    }
}

//
//  ShopAppApp.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

@main
struct ShopAppApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                GetStartedView()
            } else {
                EmptyView()
            }
        }
    }
}

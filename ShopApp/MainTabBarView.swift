//
//  MainTabBarView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct MainTabBarView: View {

    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {

            GoodsView().tabItem {
                Image(.goodsIcon)
            }
            .tag(0)

            BasketView().tabItem {
                Image(.basketIcon)
            }
            .tag(1)

            UserProfileView().tabItem {
                Image(.profileIcon)
            }
            .tag(2)
        }
        .tint(.green)
    }
}

#Preview {
    MainTabBarView()
}

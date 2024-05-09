//
//  GoodsView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct GoodsView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea(.all, edges: .top)

            VStack {
                Spacer()
                mainView
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }

    private var mainView: some View {
        VStack {
           Text("gf")
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
    }
}

#Preview {
    GoodsView()
}

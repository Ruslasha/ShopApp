//
//  AuthorisationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

struct AuthorisationView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 1)
            mainView
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            VStack {
                LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
            }
                .ignoresSafeArea(.all, edges: .all)
        )

    }

    private var mainView: some View {
        VStack {
            Text("hello")
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    AuthorisationView()
}

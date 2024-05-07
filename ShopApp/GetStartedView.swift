//
//  ContentView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        NavigationView {
            VStack {
                headerItems
                startedButton
                bottomItems
                LineView()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(
                VStack {
                    LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .top, endPoint: .bottom)
                }
                    .ignoresSafeArea(.all, edges: .all)
            )
        }
    }

    private var startedButton: some View {
        NavigationLink(destination: AuthorisationView()) {
            Text("Get Started")
                .foregroundStyle(
                    LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                )
                .foregroundColor(
                    .green
                )
                .font(.system(size: 20))
                .frame(width: 300, height: 55)
        }
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: .gray, radius: 5, x: 0, y: 4)
    }

    private var headerItems: some View {
        VStack {
            Spacer()
                .frame(height: 60)
            Text("169.ru")
                .font(.system(size: 40))
                .bold()
                .foregroundStyle(.white)
            Image("startPicture")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Spacer()
                .frame(height: 116)
        }
    }

    private var bottomItems: some View {
        VStack {
            Spacer()
                .frame(height: 75)
            Text("Don't have an account?")
                .font(.system(size: 16))
                .bold()
                .foregroundStyle(.white)
            Spacer()
                .frame(height: 12)
            Text("Sing in here")
                .font(.system(size: 28))
                .bold()
                .foregroundStyle(.white)
        }
    }
}

struct LineView: View {

    var body: some View {
        Color.white
            .frame(width: 150, height: 1)
    }
}

#Preview {
    GetStartedView()
}

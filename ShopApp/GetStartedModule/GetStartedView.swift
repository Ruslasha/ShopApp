//
//  ContentView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

struct GetStartedView: View {

    private enum Constants {
        static let title169 = "169.ru"
        static let startPicture = "startPicture"
        static let signInText = "Sign in here"
        static let getStartedText = "Get Started"
        static let dontHaveAccountText = "Don't have an account?"
        static let urlPicture = "https://st3.depositphotos.com/9881654/14953/i/450/depositphotos_149530204-stock-illustration-cute-living-room.jpg"
    }

    var body: some View {
        NavigationView {
            VStack {
                headerItems
                startedButton
                bottomItems
                Divider()
                    .frame(width: 150, height: 1)
                    .background(.white)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(
                LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .all)
            )
        }

    }

    @State private var isShowingDetail = false

    private var startedButton: some View {

        Button {
            isShowingDetail = true
        } label: {
            Text(Constants.getStartedText)
                .foregroundStyle(
                    LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                )
                .foregroundColor(.green)
                .font(.system(size: 20))
                .frame(width: 300, height: 55)
        }
        .fullScreenCover(isPresented: $isShowingDetail) {
            MainTabBarView()
        }
        .background(.white)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
    }

    private var headerItems: some View {
        VStack {
            Spacer()
                .frame(height: 60)
            Text(Constants.title169)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)
            asyncImageView
            Spacer()
                .frame(height: 116)
        }
    }

    private var asyncImageView: some View {
        AsyncImage(url: URL(string: Constants.urlPicture)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 296, maxHeight: 212)
            case .failure(_):
                Image(systemName: Constants.startPicture)
            @unknown default:
                Image(systemName: Constants.startPicture)
            }
        }
    }

    private var bottomItems: some View {
        VStack {
            Spacer()
                .frame(height: 75)
            Text(Constants.dontHaveAccountText)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
                .frame(height: 12)
            NavigationLink(destination: AuthorisationView()) {
                Text(Constants.signInText)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    GetStartedView()
}

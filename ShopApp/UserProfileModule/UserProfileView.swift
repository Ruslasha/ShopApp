//
//  UserProfileView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct UserProfileView: View {
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
            headerProfileView
            listView
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
    }

    private var listView: some View {
        VStack {
            Spacer().frame(height: 37)

            List {
                HStack {
                    listItem(image: "sityes", text: "City")
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(height: 30)
                            .foregroundStyle(
                                LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                            )
                        Text("3")
                            .foregroundColor(.white)
                    }
                }
                HStack {
                    listItem(image: "notificationsIcon", text: "Notification")
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(height: 30)
                            .foregroundStyle(
                                LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                            )
                        Text("4")
                            .foregroundColor(.white)
                    }
                }

                listItem(image: "accountDetails", text: "Account detail")
                listItem(image: "purchases", text: "My purchases")
                listItem(image: "settings", text: "Settings")
            }
            .padding(.trailing, 40)
            .font(.title3)
            .listStyle(.inset)
        }
    }

    private func listItem(image: String, text: String) -> some View {
        HStack {
            Spacer().frame(width: 40)
            Image(image)
            Text(text).foregroundStyle(.gray)
        }
    }

    private var headerProfileView: some View {
        VStack {
            Spacer()
                .frame(height: 44)
            Image(.avatar)
                .resizable()
                .frame(width: 150, height: 150)
                .background(Color.appGray)
                .clipShape(Circle())

            Text("Your Name")
                .font(.title)
                .bold()
                .foregroundStyle(.gray)
            Spacer()
                .frame(height: 1)
            HStack {
                Image(.cityIcon)
                Text("City")
                    .foregroundStyle(.gray)
            }
        }
    }

}

#Preview {
    UserProfileView()
}

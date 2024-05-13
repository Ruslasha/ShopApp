//
//  GoodCell.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct GoodCellView: View {

    var good: Good
    var indexGood : Int
    @EnvironmentObject var viewModel: GoodsViewModel
    @State private var showingSheet = false

    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .overlay(alignment: .leading) {
                Image(good.imageName)
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding()
            }
            .frame(width: 360, height: 150)
            .foregroundStyle(.appCellBackground)
            .shadow(color: .appGray, radius: 1, y: 1)
            .overlay(alignment: .trailing) {
                VStack {
                    Text(good.goodName)
                        .font(.bold(.system(size: 22))())
                        .foregroundStyle(.gray)
                    HStack(spacing: 10){
                        Text("\(good.price)$")
                            .font(.bold(.system(size: 24))())
                            .foregroundStyle(.green)
                        Text("\(good.oldPrice)$")
                            .strikethrough()
                            .font(.system(size: 24))
                            .foregroundStyle(.gray)
                    }
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .foregroundStyle(.appLightGreen)
                        .overlay(alignment: .center) {
                            HStack(spacing: 20) {
                                Button(action: {
                                    if good.count > 0 {
                                        viewModel.decreaseCountToGood(index: indexGood)
                                    }
                                }, label: {
                                    Text("-")
                                        .font(.bold(.system(size: 18))())
                                        .foregroundStyle(.gray)
                                })
                                Text(String(good.count))
                                    .font(.bold(.system(size: 18))())
                                    .foregroundStyle(.gray)
                                Button(action: {
                                    viewModel.increaseCountToGood(index: indexGood)
                                }, label: {
                                    Text("+")
                                        .font(.bold(.system(size: 18))())
                                        .foregroundStyle(.gray)
                                })
                            }
                        }
                        .frame(width: 115, height: 40)
                }
                .padding(.zero)
                .frame(width: 210)
            }
            .fullScreenCover(isPresented: $showingSheet, content: DetailView.init)
            .environmentObject(viewModel)
            .onTapGesture {
                viewModel.currentIndexGood = indexGood
                showingSheet = true
            }
    }
}

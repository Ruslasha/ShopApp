//
//  GoodsView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct GoodsView: View {

    enum Constants {
        static let yourPriceText = "Your total price"
        static let magnifImage = "magnifyingglass"
        static let seartchText = "Search..."
        static let filterText = "filter"
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    searchView
                    mainView
                        .background(.white)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
        .navigationBarItems(leading: EmptyView(), trailing: EmptyView())

        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    @State private var searchText = ""
    @ObservedObject var viewModel = GoodsViewModel()

    @ViewBuilder
    private var mainView: some View {

        priceView
        ScrollView {
            ForEach(viewModel.goods.indices, id: \.self) { goodIndex in
                GoodCellView(good: viewModel.goods[goodIndex],
                             indexGood: goodIndex)
                .environmentObject(viewModel)
            }
        }
        .padding(.top)
        if viewModel.goods.count == 0 {
            Spacer()
        }
    }

    private var priceView: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundStyle(.appLightGreen)
                .frame(width: 350, height: 48)
                .padding(.trailing, -10)
                .padding(.top)
                .overlay(alignment: .center) {
                    HStack {
                        Text(Constants.yourPriceText)
                            .font(.system(size: 24))
                            .foregroundStyle(.gray)
                            .padding(.top)
                            .padding(.trailing)
                        Text("\(viewModel.goods.map {$0.price * $0.count}.reduce(0,+))$")
                            .font(.system(size: 24))
                            .foregroundStyle(.gray)
                            .padding(.top)
                    }
                }
        }
    }

    private var searchView: some View {
        VStack {
            ZStack {
                LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(.all, edges: .top)
                VStack {
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                            .foregroundStyle(.white)
                            .overlay(alignment: .leading) {
                                HStack {
                                    Image(systemName: Constants.magnifImage)
                                        .foregroundStyle(.gray)
                                        .padding(.leading)
                                    TextField(text: $searchText) {
                                        Text(Constants.seartchText)
                                    }
                                }
                                .padding(.zero)
                            }
                            .frame(width: 312, height: 48)
                            .padding(.leading)
                        NavigationLink(destination: FiltersView().environmentObject(viewModel)) {
                            Image(Constants.filterText)
                                .padding(.trailing)
                        }

                    }
                    .padding(.vertical)
                }
            }
        }
        .ignoresSafeArea()
        .frame(height: 90)
    }
}


#Preview {
    GoodsView()
}

//
//  FiltersView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

struct FiltersView: View {

    enum Constants {
        static let titleText = "Filters"
        static let categoryText = "Category"
        static let moreText = "More"
        static let pricesText = "Prices"
        static let colorText = "Color"
        static let chevronLeft = "chevron.right"
        static let chevronRight = "chevron.left"
        static let minPriceText = "500$"
    }

    let columnsTypeFilters: [GridItem] = [
        .init(.fixed(120))
    ]

    let columnsColorsFilters: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]

    @Environment(\.presentationMode) var presentation
    var viewModel = GoodsViewModel()

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 1)
            mainView
                .background(Color.white)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea(.all, edges: .all)
        )
        .navigationTitle(Constants.titleText)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.chevronRight)
        })
                                    .foregroundStyle(.gray)
        )
        Spacer()
    }

    @State private var colorTitle: String = Constants.colorText
    @State private var price: Int = 500
    @State private var priceSliderColor: Color = .white

    private var mainView: some View {
        VStack {
            categoryView
            pricesView
            colorsView
        }
    }

    @ViewBuilder
    private var colorsView: some View {
        Spacer()
            .frame(height: 45)
        HStack {
            Text(colorTitle)
                .font(.bold(.system(size: 24))())
                .foregroundStyle(.gray)
                .padding(.horizontal)
            Spacer()
        }
        if #available(iOS 17.0, *) {
            LazyVGrid(columns: columnsColorsFilters) {
                ForEach(viewModel.sourceColors.indices, id: \.self) { indexColor in
                    Circle()
                        .stroke(.gray)
                        .fill(viewModel.sourceColors[indexColor])
                        .padding(.horizontal)
                        .onTapGesture {
                            colorTitle = "Color - \(viewModel.sourceColors[indexColor])"
                        }
                }
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private var pricesView: some View {
        HStack {
            Text(Constants.pricesText)
                .font(.bold(.system(size: 24))())
                .foregroundStyle(.gray)
                .padding(.horizontal)
            Spacer()
        }
        Slider(value: Binding(
            get: { Double(self.price) },
            set: { newValue in
                self.price = Int(newValue)
            }
        ), in: 500...5000, step: 500) {
            Text(String(price))
        } onEditingChanged: { newValue in
            print(newValue)
        }.onChange(of: price) { newValue in
            print(newValue)
        }
        .padding(.horizontal)
        .tint(.green)
        .colorMultiply(.gray)
        HStack {
            Text(Constants.minPriceText)
                .font(.system(size: 15))
                .foregroundStyle(.gray)
                .padding(.horizontal)
            Spacer()
            Text("\(Int(price))$")
                .font(.system(size: 15))
                .foregroundStyle(price == 500 ? .clear : .gray)
                .padding(.horizontal)
                .offset(x: getOffsetPriceSlider())
        }
    }

    @ViewBuilder
    private var categoryView: some View {
        Spacer()
            .frame(height: 22)
        HStack {
            Text(Constants.categoryText)
                .font(.bold(.system(size: 24))())
                .foregroundStyle(.gray)
                .padding(.horizontal)
            Spacer()
            Text(Constants.moreText)
                .font(.bold(.system(size: 24))())
                .foregroundStyle(.appGray)
            Image(systemName: Constants.chevronLeft)
                .foregroundStyle(.appGray)
                .padding(.trailing)
        }

        ScrollView(.horizontal) {
            LazyHGrid(rows: columnsTypeFilters) {
                ForEach(viewModel.sourceTypes.indices, id: \.self) { indexImage in
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .overlay {
                            Image(viewModel.sourceTypes[indexImage])
                        }
                        .frame(width: 120, height: 80)
                        .foregroundStyle(.appGray)
                        .shadow(radius: 2, y: 2)
                        .padding(.leading)
                }
            }
        }
        .padding(.horizontal)
    }

    private func getOffsetPriceSlider() -> CGFloat {
        var offset = price < 4500 ? 33 : 30
        return -CGFloat((10 - (price/500))) * CGFloat(offset)
    }
}

#Preview {
    FiltersView()
}

//
//  DetailView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 08.05.2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct DetailView: View {

    private enum Constants {
        static let articleTitle = "Article:"
        static let articleNumber = "283564"
        static let descriptionTitle = "Description:"
        static let descriptionText = "A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design."
        static let reviewTitle = "Review"
        static let maxCharacters = 300
        static let emptyReviewText = "Nothing yet"
        static let buyNowText = "Buy now"
        static let sofaText = "Sofa Elda 900"
        static let heartImage = "heart"
        static let sofaImage = "sofa"
        static let priceText = "Price: 999$"
    }

    var body: some View {
        VStack {
            mainInfoView
            priceView
            VStack {
                descriptionView
                Spacer()
                buyButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(colors: [Color.green.opacity(0.4), Color.green], startPoint: .top, endPoint: .bottom)
                    )
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
    }


    @Environment(\.dismiss) var dismiss
    private var buyButton: some View {
        VStack {
            Button {
                        dismiss()
                    } label: {
                        Text(Constants.buyNowText)
                            .foregroundStyle(
                                LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                            )
                            .frame(maxWidth: 300)
                            .padding(.vertical, 15)
                            .font(.title2.bold())
                            .background(
                                Capsule()
                                    .foregroundStyle(.white)
                            )
                            .shadow(radius: 10, y: 5)
                    }
        }
    }

    @State private var reviewText = ""

    private var descriptionView: some View {
        VStack {
                Text("\(Text(Constants.articleTitle).bold()) \(Text(Constants.articleNumber))")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(Text(Constants.descriptionTitle).bold()) \(Text(Constants.descriptionText))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Constants.reviewTitle)
                    .font(.title3)
                    .bold()
                HStack(alignment: .top) {
                    ZStack {
                        if reviewText.isEmpty {
                            TextEditor(text: $emptyText)
                                .font(.body)
                                .foregroundColor(.appGray)
                                .disabled(true)
                        }
                        TextEditor(text: $reviewText)
                            .font(.body)
                            .foregroundColor(.white)
                            .onChange(of: reviewText) { newText in
                                totalChars = newText.count
                                if totalChars <= Constants.maxCharacters {
                                    lastText = newText
                                } else {
                                    reviewText = lastText
                                }
                            }
                            .focused($reviewFocus)
                    }
                    .scrollContentBackground(.hidden)
                    if !reviewText.isEmpty {
                        Text("\(totalChars)/\(Constants.maxCharacters)")
                    }
                }
            }
            .onTapGesture {
                reviewFocus = false
            }
    }

    @FocusState private var reviewFocus: Bool
    @State private var totalChars = 0
    @State private var emptyText = Constants.emptyReviewText
    @State private var lastText = ""

    private var mainInfoView: some View {
        VStack {
            HStack  {
                Text(Constants.sofaText)
                    .foregroundStyle(.gray)
                Spacer()
                Image(Constants.heartImage)
            }
            Spacer()
            Image(Constants.sofaImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .foregroundStyle(.appGray)
        .font(.title2.bold())
        .frame(height: 250)
    }

    private var priceView: some View {
        HStack {
            Spacer()
            Text(Constants.priceText)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .foregroundStyle(.gray)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.appBrown)
                        .ignoresSafeArea()
                )
        }
        .offset(x: 10)
        .foregroundStyle(.appGray)
        .font(.title2.bold())
    }
}

@available(iOS 16.0, *)
#Preview {
    DetailView()
}

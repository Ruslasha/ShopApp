//
//  GoodsViewModel.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 09.05.2024.
//

import SwiftUI

final class GoodsViewModel: ObservableObject {

    @Published var goods: [Good] = [
        Good(imageName: "goodFirst", goodName: "Sofa", price: 999, oldPrice: 2000, count: 0),
        Good(imageName: "goodSecond", goodName: "Armchair", price: 99, oldPrice: 200, count: 0),
        Good(imageName: "goodThree", goodName: "Bed", price: 1000, oldPrice: 2000, count: 0),
        Good(imageName: "goodFour", goodName: "Chair", price: 99, oldPrice: 200, count: 0),
        Good(imageName: "goodFive", goodName: "Wardrobe", price: 899, oldPrice: 1100, count: 0),
        Good(imageName: "goodSix", goodName: "Table", price: 600, oldPrice: 1200, count: 0)
    ]
    @Published var currentIndexGood: Int?
    @Published var sourceTypes: [String] = [
        "filterBed",
        "filterSofa",
        "filterChair"
    ]
    @Published var sourceColors: [Color] = [
        .white, .black, .gray, .purple, .orange,
        .red, .green, .blue, .pink, .yellow,
        .indigo, .brown, .cyan, .blue,  .mint, .teal,
        .red, .yellow, .green,  .pink, 
    ]

    func increaseCountToGood(index: Int) {
        goods[index].count += 1
    }

    func decreaseCountToGood(index: Int) {
        goods[index].count -= 1
    }

    func getCurrentGood() -> Good {
        guard let index = currentIndexGood else {
            return Good(imageName: "", goodName: "", price: 0, oldPrice: 0, count: 0)
        }
        return goods[index]
    }
}

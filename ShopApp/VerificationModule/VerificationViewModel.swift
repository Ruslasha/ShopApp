//
//  VerificationViewModel.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 08.05.2024.
//

import Foundation

final class VerificationViewModel: ObservableObject {
    @Published var smsAlertIsShow = false
    var smsText = Int.random(in: 1000...9999)
}

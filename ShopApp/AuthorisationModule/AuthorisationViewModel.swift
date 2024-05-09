//
//  AuthorisationViewModel.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 07.05.2024.
//

import Foundation

final class AuthorisationViewModel: ObservableObject {

    @Published var isPasswordHidden = true

    private let phoneMask = "+X(XXX)XXX-XX-XX"

    func format(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in phoneMask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}

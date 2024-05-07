//
//  VerificationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 07.05.2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct VerificationView: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 1)
                mainView
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(
                VStack {
                    LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                }
                    .ignoresSafeArea(.all, edges: .all)
            )

        }
        .navigationTitle("Verification")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
                                    .foregroundStyle(.gray)
        )
    }

    private var mainView: some View {
        VStack {
            mailImageView
            textFields
            smsLabels
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)

    }

    private var smsLabels: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Text("Check the SMS")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.gray)
            Text("message to get verification code")
                .font(.system(size: 16))
                .foregroundStyle(.gray)
        }
    }

    private var mailImageView: some View {
        VStack {
            Image("mail")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Verification code")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
        }
    }

    @State private var numberOneCode = ""
    @State private var numberTwoCode = ""
    @State private var numberThreeCode = ""
    @State private var numberFourCode = ""
    @State var totalChars = 0
    @State private var lastOneCode = ""
    @State private var lastTwoCode = ""
    @State private var lastThreeCode = ""
    @State private var lastFourCode = ""

    @FocusState private var focusedField: Int?

    private var textFields: some View {
        VStack {
            HStack {
                TextField("", text: $numberOneCode)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 60, height: 60)
                    .font(.system(size: 40))
                    .focused($focusedField, equals: 1)
                    .onChange(of: numberOneCode) { text in
                        totalChars = text.count
                        if totalChars <= 1 {
                            lastOneCode = text
                            focusedField = 2
                        } else {
                            numberOneCode = lastOneCode
                        }
                    }

                TextField("", text: $numberTwoCode)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 60, height: 60)
                    .font(.system(size: 40))
                    .focused($focusedField, equals: 2)
                    .onChange(of: numberTwoCode) { text in
                        totalChars = text.count
                        if totalChars <= 1 {
                            lastTwoCode = text
                            focusedField = 3
                        } else {
                            numberTwoCode = lastTwoCode
                        }
                    }

                TextField("", text: $numberThreeCode)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 60, height: 60)
                    .font(.system(size: 40))
                    .onChange(of: numberThreeCode) { text in
                        totalChars = text.count
                        if totalChars <= 1 {
                            lastThreeCode = text
                            focusedField = 4
                        } else {
                            numberThreeCode = lastThreeCode
                        }
                    }
                    .focused($focusedField, equals: 3)

                TextField("", text: $numberFourCode)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 60, height: 60)
                    .font(.system(size: 40))
                    .focused($focusedField, equals: 4)
                    .onChange(of: numberFourCode) { text in
                        totalChars = text.count
                        if totalChars <= 1 {
                            lastFourCode = text
                            focusedField = nil
                        } else {
                            numberFourCode = lastFourCode
                        }
                    }
            }
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        VerificationView()
    } else {
        EmptyView()
    }
}

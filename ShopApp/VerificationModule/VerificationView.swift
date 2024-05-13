//
//  VerificationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 07.05.2024.
//

import SwiftUI

struct VerificationView: View {

    enum Constants {
        static let verification = "Verification"
        static let chevronLeft = "chevron.left"
        static let didntReciveSms = "Didn’t receive sms"
        static let sendSmsAgain =  "Send sms again"
        static let fillInFromMessage = "Fill in from message"
        static let cancelText = "Cancel"
        static let okText = "Ok"
        static let continueText = "Continue"
        static let checkSmsText = "Check the SMS"
        static let messageText = "message to get verification code"
        static let mailText = "mail"
        static let verificationCodeText = "Verification code"
    }

    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        VStack {
            Spacer()
                .frame(height: 1)
            mainView
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea(.all, edges: .all)
        )
        .navigationTitle(Constants.verification)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.chevronLeft)
        })
                                    .foregroundStyle(.gray)
        )
    }

    @ObservedObject private var viewModel = VerificationViewModel()
    @State private var verificationTexts = ["", "", "", ""]
    @State private var numberOneCode = ""
    @State private var numberTwoCode = ""
    @State private var numberThreeCode = ""
    @State private var numberFourCode = ""
    @State var totalChars = 0
    @State private var lastOneCode = ""
    @State private var lastTwoCode = ""
    @State private var lastThreeCode = ""
    @State private var lastFourCode = ""
    @FocusState private var focusedFieldIndex: Int?

    private var mainView: some View {
        VStack {
            mailImageView
            textFields
            smsLabels
            continueButtonView
            sendSmsButton
            Divider()
                .frame(maxWidth: 180, maxHeight: 1)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
        .foregroundStyle(Color(uiColor: .darkGray))
    }

    private var sendSmsButton: some View {
        VStack {
            Text(Constants.didntReciveSms)
                .font(.system(size: 16))
                .foregroundStyle(.gray)
                .frame(height: 20)
            Button(action: {
                viewModel.smsAlertIsShow = true
            }) {
                Text(Constants.sendSmsAgain)
                    .font(.title)
                    .bold()
            }
            .alert(Constants.fillInFromMessage, isPresented: $viewModel.smsAlertIsShow) {
                Button(Constants.cancelText, role: .cancel) {}
                Button(Constants.okText) {
                    pasteSmsText(String(viewModel.smsText))
                }
            } message: {
                Text(String(viewModel.smsText))
            }
        }
    }

    private func pasteSmsText(_ text: String) {
        for (index, value) in text.enumerated() {
            verificationTexts[index] = String(value)
        }
        numberOneCode = verificationTexts[0]
        numberTwoCode = verificationTexts[1]
        numberThreeCode = verificationTexts[2]
        numberFourCode = verificationTexts[3]
    }

    private var continueButtonView: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Button {} label: {
                Text(Constants.continueText)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 100)
                    .font(.title2.bold())
                    .background(
                        LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                    )
                    .shadow(radius: 10, y: 5)
                    .foregroundStyle(.white)

            }
            .cornerRadius(27)
        }
    }


    private var smsLabels: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Text(Constants.checkSmsText)
                .font(.system(size: 20, weight: .bold))
                .frame(height: 30)
            Text(Constants.messageText)
                .font(.system(size: 16))
                .frame(height: 20)
        }
    }

    private var mailImageView: some View {
        VStack {
            Image(Constants.mailText)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(Constants.verificationCodeText)
                .font(.system(size: 20))
        }
    }

    @ViewBuilder
    private var textFields: some View {
        HStack {
            TextField("", text: $numberOneCode)
                .frame(width: 60, height: 60)
                .focused($focusedFieldIndex, equals: 1)
                .onChange(of: numberOneCode) { text in
                    totalChars = text.count
                    if totalChars <= 1 {
                        lastOneCode = text
                        focusedFieldIndex = 2
                    } else {
                        numberOneCode = lastOneCode
                    }
                }
            TextField("", text: $numberTwoCode)
                .frame(width: 60, height: 60)
                .focused($focusedFieldIndex, equals: 2)
                .onChange(of: numberTwoCode) { text in
                    totalChars = text.count
                    if totalChars <= 1 {
                        lastTwoCode = text
                        focusedFieldIndex = 3
                    } else {
                        numberTwoCode = lastTwoCode
                    }
                }
            TextField("", text: $numberThreeCode)
                .frame(width: 60, height: 60)
                .onChange(of: numberThreeCode) { text in
                    totalChars = text.count
                    if totalChars <= 1 {
                        lastThreeCode = text
                        focusedFieldIndex = 4
                    } else {
                        numberThreeCode = lastThreeCode
                    }
                }
                .focused($focusedFieldIndex, equals: 3)
            TextField("", text: $numberFourCode)
                .frame(width: 60, height: 60)
                .focused($focusedFieldIndex, equals: 4)
                .onChange(of: numberFourCode) { text in
                    totalChars = text.count
                    if totalChars <= 1 {
                        lastFourCode = text
                        focusedFieldIndex = nil
                    } else {
                        numberFourCode = lastFourCode
                    }
                }
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .font(.system(size: 40))
    }
}


#Preview {
        VerificationView()
}

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
            continueButtonView
            sendSmsButton
            Divider()
                .frame(maxWidth: 180, maxHeight: 1)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)

    }

    @ObservedObject private var viewModel = VerificationViewModel()
    @State private var verificationTexts = ["", "", "", ""]

    private var sendSmsButton: some View {
        VStack {
            Text("Didn’t receive sms")
                .font(.system(size: 16))
                .foregroundStyle(.gray)
                .frame(height: 20)
            Button(action: {
                viewModel.smsAlertIsShow = true
            }) {
                Text("Send sms again")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.gray)
            }
            .alert("Fill in from message", isPresented: $viewModel.smsAlertIsShow, actions: {
                Button("Cancel", role: .cancel, action: {})
                Button("Ok", action: {
                    pasteSmsText(String(viewModel.smsText))
                })
            }, message: {
                Text(String(viewModel.smsText))
            })
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
                Text("Continue")
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
            Text("Check the SMS")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.gray)
                .frame(height: 30)
            Text("message to get verification code")
                .font(.system(size: 16))
                .foregroundStyle(.gray)
                .frame(height: 20)
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

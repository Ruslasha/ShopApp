//
//  AuthorisationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

struct AuthorisationView: View {

    enum Constants {
        static let forgotText = "Forgot your password?"
        static let phoneSupportText = "Телефон поддержки"
        static let phoneSupport = "+7(948)345-34-23"
        static let logInText = "Log in"
        static let singUpText = "Sing up"
        static let placeholderPhone = "+9(999)999-99-99"
        static let placeholderDot = "*******"
        static let errorText = "Ошибка"
        static let passwordErrorText = "Пароль не может быть меньше 6 символов"
        static let checkVerification = "Check Verification"
    }

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = AuthorisationViewModel()
    @FocusState var phoneIsFocused: Bool
    @FocusState var passwordIsFocused: Bool
    @State var totalPasswordChars = 0
    @State var lastPasswordText = ""

    var body: some View {
        NavigationView {
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

        }
        .navigationBarBackButtonHidden(true)
    }

    @State private var phoneNumberText = ""
    @State private var passwordText = ""
    @State private var forgotAlertIsShow = false
    @State private var passwordAlertIsShow = false

    private var mainView: some View {
        VStack {
            Spacer()
                .frame(height: 37)
            pickerView
            Spacer()
                .frame(height: 78)
            phoneTextFieldView
            Divider()
            Spacer()
                .frame(height: 24)
            passwordTextFieldView
            Divider()
            Spacer()
                .frame(height: 111)
            signUpButtonView
            Spacer()
                .frame(height: 24)
            Button {
                forgotAlertIsShow = true
            } label: {
                Text(Constants.forgotText)
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(.gray)
            }
            .alert(Constants.phoneSupportText, isPresented: $forgotAlertIsShow) {
            } message: {
                Text(Constants.phoneSupport)
            }
            Spacer()
                .frame(height: 18)
            NavigationLink(destination: VerificationView()) {
                checkVerificationView
            }
            Divider()
                .frame(maxWidth: 180, maxHeight: 1)
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    private var pickerView: some View {
        HStack(spacing: 0) {
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 27.0,
                    bottomLeading: 27.0,
                    bottomTrailing: 0,
                    topTrailing: 0),
                                       style: .continuous)
                .stroke(.appGray, lineWidth: 2)
                .frame(width: 150, height: 51)
                .overlay {
                    Text(Constants.logInText)
                        .foregroundStyle(
                            LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        )
                        .font(.title2.bold())
                }

                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: 27.0,
                    topTrailing: 27.0),
                                       style: .continuous)
                .frame(width: 150, height: 53)
                .foregroundStyle(.appGray)
                .overlay {
                    Text(Constants.singUpText)
                        .foregroundStyle(
                            LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                        )
                        .font(.title2.bold())
                }
            } else {

            }
        }
    }

    private var phoneTextFieldView: some View {
        TextField(Constants.placeholderPhone, text: $phoneNumberText)
            .font(.title2)
            .font(Font.headline.bold())
            .onChange(of: phoneNumberText) { text in
                phoneNumberText = viewModel.format(phone: text)
            }
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
            .focused($phoneIsFocused)
    }

    private var passwordTextFieldView: some View {

        HStack {
            Group {
                if viewModel.isPasswordHidden {
                    SecureField(Constants.placeholderDot, text: $passwordText)
                        .font(.title2.bold())
                } else {
                    TextField(Constants.placeholderDot, text: $passwordText)
                        .font(.title2.bold())
                }
            }
            .focused($passwordIsFocused)
            .onChange(of: passwordText) { text in
                totalPasswordChars = text.count
                if totalPasswordChars <= 15 {
                    lastPasswordText = text
                } else {
                    passwordText = lastPasswordText
                    passwordIsFocused = false
                }
            }
            Button(action: {
                viewModel.isPasswordHidden.toggle()
            }){
                Image(viewModel.isPasswordHidden ? "invisible" : "visible")
            }
        }
        .padding(.horizontal, 20)

    }

    @State var isShowingVerificationScreen = false
    private var signUpButtonView: some View {
        Button {
            if passwordText.count < 6 {
                passwordAlertIsShow = true
            } else {
                isShowingVerificationScreen = true
            }
        } label: {
            Text(Constants.singUpText)
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

        .alert(Constants.errorText, isPresented: $passwordAlertIsShow) {
        } message: {
            Text(Constants.passwordErrorText)
        }
    }

    private var checkVerificationView: some View {

        Text(Constants.checkVerification)
            .font(.title.bold())
            .foregroundStyle(.gray)

    }

}

#Preview {
        AuthorisationView()
}

//
//  AuthorisationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

@available(iOS 16.0, *)
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
                VStack {
                    LinearGradient(colors: [Color.green.opacity(0.2), Color.green], startPoint: .leading, endPoint: .trailing)
                }
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
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 24)
            passwordTextFieldView
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 111)
            signUpButtonView

            Spacer()
                .frame(height: 24)
            Button(action: {
                forgotAlertIsShow = true
            }) {
                Text(Constants.forgotText)
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(.gray)
            }
            .alert(Constants.phoneSupportText, isPresented: $forgotAlertIsShow, actions: {
            }, message: {
                Text(Constants.phoneSupport)
            })
            Spacer()
                .frame(height: 18)
            NavigationLink(destination: VerificationView()) {
                checkVerificationView
            }
            Divider()
                .frame(maxWidth: 180, maxHeight: 1)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    private var pickerView: some View {
        HStack(spacing: 0) {
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
        }
    }

    private var phoneTextFieldView: some View {
        TextField(Constants.placeholderPhone, text: $phoneNumberText)
            .font(.title2)
            .bold()
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
                if viewModel.passwordIsHide {
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
                viewModel.passwordIsHide.toggle()
            }){
                Image(viewModel.passwordIsHide ? "invisible" : "visible")
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)

    }

    @State var movetoNextScreen: Int? = nil
    private var signUpButtonView: some View {
        Button {
            if passwordText.count < 6 {
                passwordAlertIsShow = true
                movetoNextScreen = 0
            } else {
                movetoNextScreen = 1
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
        .background(
            NavigationLink(destination: VerificationView(), tag: 1,
                           selection: $movetoNextScreen) { EmptyView() }
        )

        .alert(Constants.errorText, isPresented: $passwordAlertIsShow, actions: {
        }, message: {
            Text(Constants.passwordErrorText)
        })
    }

    private var checkVerificationView: some View {

        Text(Constants.checkVerification)
            .font(.title.bold())
            .foregroundStyle(.gray)

    }

}

#Preview {
    if #available(iOS 16.0, *) {
        AuthorisationView()
    } else {
        EmptyView()
    }
}

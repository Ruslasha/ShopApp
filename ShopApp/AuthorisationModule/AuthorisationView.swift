//
//  AuthorisationView.swift
//  ShopApp
//
//  Created by Руслан Абрамов on 06.05.2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct AuthorisationView: View {

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
        .navigationBarBackButtonHidden(true)
        //        .navigationBarItems(leading:
        //                                Button(action: {
        //            presentationMode.wrappedValue.dismiss()
        //        }, label: {
        //            Image(systemName: "chevron.left")
        //        })
        //                                    .foregroundStyle(.gray)
        //        )
    }

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
                Text("Forgot your password?")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(.gray)
            }
            .alert("Телефон поддержки", isPresented: $forgotAlertIsShow, actions: {
            }, message: {
                Text("+7(948)345-34-23")
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
                Text("Log in")
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
                Text("Sing up")
                    .foregroundStyle(
                        LinearGradient(colors: [Color.green, Color.green.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    )
                    .font(.title2.bold())
            }
        }
    }

    @ObservedObject var viewModel = AuthorisationViewModel()
    @State private var phoneNumberText = ""
    @State private var passwordText = ""
    @FocusState var phoneIsFocused: Bool
    @FocusState var passwordIsFocused: Bool
    @State var totalPasswordChars = 0
    @State var lastPasswordText = ""
    @State private var forgotAlertIsShow = false
    @State private var passwordAlertIsShow = false

    private var phoneTextFieldView: some View {
        TextField("+9(999)999-99-99", text: $phoneNumberText)
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
                    SecureField("*******", text: $passwordText)
                        .font(.title2.bold())
                } else {
                    TextField("*******", text: $passwordText)
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
            .onSubmit {
                if passwordText.count < 6 {
                    passwordAlertIsShow = true
                }
            }
            .alert("Ошибка", isPresented: $passwordAlertIsShow, actions: {
            }, message: {
                Text("Пароль не может быть меньше 6 символов")
            })
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
            Text("Sing up")
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

        .alert("Ошибка", isPresented: $passwordAlertIsShow, actions: {
        }, message: {
            Text("Пароль должен быть больше 6 симоволов")
        })
    }

    private var checkVerificationView: some View {

        Text("Check Verification")
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

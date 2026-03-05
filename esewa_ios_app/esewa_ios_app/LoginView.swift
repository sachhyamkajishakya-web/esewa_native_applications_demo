//
//  LoginView.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 04/03/2026.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var usernameErrorMessage: String = ""
    @State private var passwordErrorMessage: String = ""
    @FocusState private var isUsernameFieldFocused: Bool
    @FocusState private var isPasswordFieldFocused: Bool
    @State private var showAlert = false
//    using persistent storage to store generated UUID
    @AppStorage("userUUID") var uuid: String = ""
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Login").font(.system(size: 40)).fontWeight(.bold).padding(.bottom, 50)
            TextField("Username", text: $username, prompt: Text("Username").foregroundColor(.gray).font(.system(size: 12)))
                .padding(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(isUsernameFieldFocused ? "borderColor" : "unfocusedBorderColor"), lineWidth: 1)
                )
                .onChange(of: username) { _, _ in
                    usernameErrorMessage = ""
                }
                .textInputAutocapitalization(.never)
                .tint(Color("borderColor"))
                .focused($isUsernameFieldFocused)
            if !usernameErrorMessage.isEmpty {
                Text(usernameErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.gray).font(.system(size: 12)))
                .padding(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(isPasswordFieldFocused ? "borderColor" : "unfocusedBorderColor"), lineWidth: 1)
                )
                .onChange(of: password) { _, _ in
                    passwordErrorMessage = ""
                }
                .textInputAutocapitalization(.never)
                .tint(Color("borderColor"))
                .focused($isPasswordFieldFocused)
            if !passwordErrorMessage.isEmpty {
                Text(passwordErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button {
                if checkUsernameAndPassword() {
                    uuid = UUID().uuidString
                    print("Valid username and password \(uuid)")
                } else {
                    print("invalid username nad password")
                }

            } label: {
                Text("Login").foregroundStyle(Color("buttonTextColor")).padding(.all, 10).font(.system(size: 18)).fontWeight(.bold)

            }.buttonStyle(.borderedProminent)
                .padding(.top, 20).tint(Color("primary")).alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Invalid username and password.")
                    )
                }.frame(width: 200, height: 52)
        }
        .padding(.horizontal)
    }

    func checkUsernameAndPassword() -> Bool {
        if username.isEmpty {
            usernameErrorMessage = "Username is required."
            return false
        } else if username.wholeMatch(of: /[a-zA-Z0-9 ]+/) == nil {
            usernameErrorMessage = "Username must only contain characters and numbers."
            return false
        } else if username.count < 3 || username.count > 20 {
            usernameErrorMessage = "Username must be 3 to 20 characters long."
        }
        if password.isEmpty {
            passwordErrorMessage = "Password is required."
            return false
        } else if !password.isValidPassword() {
            passwordErrorMessage =
                "Password must contain\n \u{2022}1 digit\n \u{2022}1 lowercase\n \u{2022}1 uppercase\n \u{2022}1 special character\n \u{2022}at least 8 characters"
            return false
        }

        if username.trimmingCharacters(in: .whitespaces) != "Demo Esewa User" && password.trimmingCharacters(in: .whitespaces) != "esewa2026@Demo" {
            showAlert = true
            return false
        }
        return true
    }
}

#Preview {
    LoginView()
        .modelContainer(for: Item.self, inMemory: true)
}

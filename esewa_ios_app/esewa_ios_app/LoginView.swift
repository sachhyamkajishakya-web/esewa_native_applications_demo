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
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Login").font(.system(size: 40)).fontWeight(.bold).padding(.bottom, 50)
            TextField("Username", text: $username, prompt: Text("Username").foregroundColor(.gray).font(.system(size: 12)))
                .padding(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(isUsernameFieldFocused ? "primary" : "borderColor"), lineWidth: 1)
                )
                .textInputAutocapitalization(.never)
                .tint(Color("primary"))
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
                        .stroke(Color(isUsernameFieldFocused ? "primary" : "borderColor"), lineWidth: 1)
                )
                .textInputAutocapitalization(.never)
                .tint(Color("primary"))
                .focused($isPasswordFieldFocused)
            if !passwordErrorMessage.isEmpty {
                Text(passwordErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button {
                if checkUsernameAndPassword() {
                    print("Valid username and password")
                } else {
                    print("invalid username nad password")
                }

            } label: {
                Text("Login").foregroundStyle(Color("buttonTextColor")).padding(.all, 10)

            }.buttonStyle(.borderedProminent)
                .padding(.top, 20).tint(Color("primary"))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
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
            return false
        }
        return true
    }
}

#Preview {
    LoginView()
        .modelContainer(for: Item.self, inMemory: true)
}

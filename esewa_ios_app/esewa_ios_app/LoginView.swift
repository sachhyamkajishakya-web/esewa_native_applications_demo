//
//  LoginView.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 04/03/2026.
//


import SwiftUI
import SwiftData

struct LoginView: View {
    
    @State private var username:String = "";
    @State private var password:String = "";
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Login").font(.system(size: 40)).fontWeight(.bold).padding(.bottom,50)
            TextField("Username",text: $username, prompt: Text("Username").foregroundColor(.gray).font(.system(size: 14)))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .border(.black)
            SecureField("Password",text: $password, prompt: Text("Password").foregroundColor(.gray).font(.system(size: 14)))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .border(.black)
            Button{
                
            } label: {
                Text("Login")
                    .foregroundStyle(.white)
                    .background(.blue)
            }.buttonStyle(.borderedProminent)
                .padding(.top, 20)
        }.padding(.horizontal)
            .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    LoginView()
        .modelContainer(for: Item.self, inMemory: true)
}

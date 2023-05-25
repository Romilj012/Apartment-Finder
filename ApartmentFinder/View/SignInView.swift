//
//  SignInView.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/30/23.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 16) {
                    TextField("Email Address", text: $email)                        //Text field to write email if already account exists of the Owner
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)                        //Text field to write password corresponding with the account of the Owner
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {              //authorize if email and password already exist
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        viewModel.getLoggedInUserName()
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                NavigationLink("Create Account", destination: SignUpView(signUpType: .regular))             //create account button if new user
                    .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Owner Sign In")
    }
}

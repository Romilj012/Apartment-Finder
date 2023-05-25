//
//  SignUpView.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 3/30/23.
//

import SwiftUI

struct SignUpView: View {
    enum SignUpType {
        case regular
    }
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var phone = ""
    @EnvironmentObject var viewModel: AppViewModel
    let signUpType: SignUpType
    
    
    //SIGNUP VIEW
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 16) {
                    TextField("Email Address", text: $email)                    //Enter email address
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Name", text: $name)                              //Enter name
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Phone", text: $phone)                            //Enter phone number
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        
                    SecureField("Password", text: $password)                 //Enter Password
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        switch signUpType {
                        case .regular:
                            viewModel.signUp(email: email, password: password, name: name, phone: phone)
                        }
                    }) {
                        Text("Create Account")                          //Click on create button to create account
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("Create Account")
    }
}

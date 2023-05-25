//
//  StudentSignUpView.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 5/6/23.
//

import SwiftUI


struct StudentSignUpView: View {
    enum StudentSignUpType {
        case student
    }
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @EnvironmentObject var viewModel: AppViewModel
    let studentsignUpType: StudentSignUpType
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 16) {
                    TextField("Email Address", text: $email)                     //Enter email
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Name", text: $name)                               //Enter name
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)                       //Enter password
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        switch studentsignUpType {
                        case .student:
                            viewModel.studentSignUp(email: email, password: password, name: name)
                        }
                    }) {
                        Text("Create Account")                                    //Click on create button to create account
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
            .padding()
        }
        .navigationTitle("Create Account")
    }
}

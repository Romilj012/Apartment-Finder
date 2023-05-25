//
//  StudentHome.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 4/3/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct StudentHome:View{
    
    @EnvironmentObject var viewModel:AppViewModel
    @State var presentAddApartmentSheet = false
    
    var body: some View {
        VStack {
            DisplayAllApartment()               //To display all the apartment list added by multiple owners
            
            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out!")               //Sign out button
                    .foregroundColor(.blue)
                    .padding()
            }
            
            // Spacer()
        }
        // .frame(maxHeight: .infinity, alignment: .bottom)
        .navigationBarTitle("Welcome, \(viewModel.studentUserName)")
        .onAppear {
            viewModel.getLoggedInStudentUserName()
        }
    }
}

//
//  Home.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/30/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Home:View{

    @EnvironmentObject var viewModel:AppViewModel
    @State var presentAddApartmentSheet = false

    private var addButton:some View{
        Button(action: {self.presentAddApartmentSheet.toggle()}){
            Image(systemName: "plus")
        }
    }

    var body: some View {
        VStack {
            DisplayApartment()                      //To display all apartment list added by the logged in Owner
            
            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out!")                   //Sign out button
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        // .frame(maxHeight: .infinity, alignment: .bottom)
        .navigationBarTitle("Welcome, \(viewModel.userName)")
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.getLoggedInUserName()
        }
    }
}





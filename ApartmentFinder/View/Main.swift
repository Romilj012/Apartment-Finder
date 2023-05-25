//
//  Main.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView{
            //CHECK IF USER IS SIGNED IN 
            if viewModel.signedIn{
                Home()                                                      //Owner home page
                    .background(Color.black.edgesIgnoringSafeArea(.all))
            }
                //DisplayApartment()
               else if viewModel.studentSignedIn{
                StudentHome()                                                       //Student home page
                       .background(Color.black.edgesIgnoringSafeArea(.all))
//                }
            }else{
                FirstScreen()                                                   //Choose whether an owner or student screen
                    .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
        .onAppear{
            if  viewModel.isSignedIn{
                viewModel.signedIn = viewModel.isSignedIn
            }
            else{
                viewModel.studentSignedIn = viewModel.isSignedIn
            }
        }
    }
}


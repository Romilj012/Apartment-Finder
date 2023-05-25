//
//  First Screen.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 4/3/23.
//

import SwiftUI

struct FirstScreen: View {
    @State private var showContent = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("SU Apartment Finder 🏠")
                    .font(.custom("HelveticaNeue-Bold", size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1.0 : 0.2)
                    .rotationEffect(.degrees(showContent ? 0 : -45))
                    .animation(Animation.easeInOut(duration: 0.5)) // Replaced .spring with .easeInOut
                    .onAppear {
                        withAnimation {
                            showContent = true
                        }
                    }
                
                Spacer()
                
                Image("Image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 50)
                    .opacity(showContent ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.5)) // Replaced .spring with .easeInOut
                
                Spacer()
                
                NavigationLink(destination: SignInView()) {
                    Text("Owner")                                       //If owner show owner signin view
                        .font(.title2)
                        .padding()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        )
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 3, x: 0, y: 2)
                }
                .opacity(showContent ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.5)) // Added opacity animation
                
                Spacer()
                
                NavigationLink(destination: StudentSignInView()) {
                    Text("Student")                                         //If student show student signin view
                        .font(.title2)
                        .padding()
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        )
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 3, x: 0, y: 2)
                }
                .opacity(showContent ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.5)) // Added opacity animation
                
                Spacer()
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct First_Screen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}

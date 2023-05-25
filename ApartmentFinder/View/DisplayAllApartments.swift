//
//  DisplayAllApartments.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 4/3/23.
//
//

import SwiftUI
import SDWebImageSwiftUI

struct DisplayAllApartment: View {                              //Display all the apartments listed by various owners
    @EnvironmentObject var viewModel: AppViewModel
    @State private var presentAddApartmentSheet = false
    @State private var searchText = ""
    @State private var selectedMinBeds = 0
    @State private var selectedMaxBeds = 0
    @State private var selectedMinBaths = 0
    @State private var selectedMaxBaths = 0
    @State private var selectedMinRent = 0
    @State private var selectedMaxRent = 0


    private func apartmentRowView(apartment: Apartment) -> some View {
        NavigationLink(destination: ApartmentDetailView(apartment: apartment)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    WebImage(url: URL(string: apartment.images[0]))
                        .resizable()
                        .placeholder {
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        }
                        .indicator(.activity)
                        .frame(width: 65, height: 65)
                        .cornerRadius(8)
                        .shadow(radius: 4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(apartment.description)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("$\(apartment.price)/month")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(apartment.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")                     //Search functionality to search a particular apartment 
                        .padding(.leading, 16)
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
                }

                List {
                    ForEach(viewModel.apartments.filter { apartment in
                        searchText.isEmpty || apartment.description.localizedCaseInsensitiveContains(searchText)
                    }) { apartment in
                        apartmentRowView(apartment: apartment)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Apartments Listings")
                .onAppear {
                    viewModel.getStudentAllApartments()
                }
                .sheet(isPresented: $presentAddApartmentSheet) {
                    ApartmentEditView()
                }.padding(.top, 0)
                
            }
        }
    }
}
struct DisplayAllApartment_Previews: PreviewProvider {
    static var previews: some View {
        DisplayAllApartment()
            .environmentObject(AppViewModel())
    }
}

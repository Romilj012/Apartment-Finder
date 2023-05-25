//
//  DisplayApartment.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/31/23.
//
//

import SwiftUI
import SDWebImageSwiftUI

//DISPLAY APARTMENTS added by the owner
struct DisplayApartment: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var presentAddApartmentSheet = false
    @State private var searchText = ""
    
    private var addButton: some View {
        Button(action: { self.presentAddApartmentSheet.toggle() }) {
            HStack {
                Image(systemName: "plus")
                Text("Add Listing")                             // Add new lisiting by clicking on the plus button
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .padding(.top, 5)
        }
    }
    
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
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 16)
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)              //Search functionality to search a particular apartment 
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
                .navigationBarTitle("Your Listings")
                .navigationBarItems(trailing: addButton)
                .onAppear {
                    viewModel.getAllApartments()
                }
                .sheet(isPresented: $presentAddApartmentSheet) {
                    ApartmentEditView()
                }.padding(.top, 0)
            }
        }
    }
}

struct DisplayApartment_Previews: PreviewProvider {
    static var previews: some View {
        DisplayApartment()
            .environmentObject(AppViewModel())
    }
}

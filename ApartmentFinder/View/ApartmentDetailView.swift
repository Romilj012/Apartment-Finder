//
//  ApartmentDetailView.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/31/23.
//
import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage
import MapKit

struct ApartmentDetailView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @EnvironmentObject var viewModel: AppViewModel
    @State var owner: Owner?
    var apartment: Apartment
    @State var uiimage = URL(string: "")

    // Map region properties
    @State private var region = MKCoordinateRegion()
    @State private var annotation: MKPointAnnotation?

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Apartment")) {
                    Text(apartment.location)
                        .font(.title)
                    Text("Price is \(apartment.price)/month")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Description")) {
                    Text(apartment.description)
                }
                
                AnimatedImage(url: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        getImage(image: apartment.images[0])
                    }
        if viewModel.studentSignedIn && apartment.ownerId != viewModel.userName {
                Button("Send Message") {
                    print(apartment.ownerId)
                    
                    var phoneNumber = ""
                    self.viewModel.getLoggedInOwnerInfo(ownerID: apartment.ownerId) { owner, error in
                        phoneNumber = self.owner?.phone ?? ""
                    }
                    
                    print("================>>>>><<<<<<=========")
                    print(phoneNumber)
                    
                    // Dynamically getting the phone number
                    // let urlWhats = "https://wa.me/1\(phoneNumber)?text=could you send me more details about this property"
                    // Hardcoded phone number for testing
                    let urlWhats = "https://wa.me/13156037876?text=could you send me more details about this property"
                    
                    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        if let whatsappURL = URL(string: urlString) {
                            if UIApplication.shared.canOpenURL(whatsappURL) {
                                UIApplication.shared.openURL(whatsappURL)
                            } else {
                                print("Install Whatsapp")
                            }
                        }
                    }
                }
            }
            }
            
            // Map view for the address
            if verticalSizeClass == .regular {
                Map(coordinateRegion: $region, annotationItems: [annotation].compactMap { $0 }) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        Image(systemName: "mappin")
                            .onTapGesture {
                                openMaps(coordinate: item.coordinate)
                            }
                    }
                }
                .frame(height: 200)
                .onAppear {
                    // Set the map region and annotation based on the apartment's address
                    let geocoder = CLGeocoder()
                    geocoder.geocodeAddressString(apartment.location) { placemarks, error in
                        if let placemark = placemarks?.first, let location = placemark.location {
                            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            annotation = MKPointAnnotation()
                            annotation?.coordinate = location.coordinate
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Apartment Details")
        .padding()
    }

    func getImage(image: String) {
        let storageRef = Storage.storage().reference()
        let fileref = storageRef.child(image)
        fileref.downloadURL { url, error in
            if error == nil {
                uiimage = url
            }
        }
    }
    func openMaps(coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = apartment.location
        mapItem.openInMaps(launchOptions: nil)
    }
}

extension MKPointAnnotation: Identifiable {
    public var id: String? {
        title
    }
}


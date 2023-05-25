//
//  Apartment.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 3/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import MapKit

struct Apartment: Codable, Identifiable {
    var id: String?
    var location: String
    var price: String
    var description: String
    var images: [String]
    var ownerId: String
    var latitude: Double
    var longitude: Double
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

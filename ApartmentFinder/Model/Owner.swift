//
//  Owner.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 4/13/23.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Owner:Codable,Identifiable{
     var id: String
    var email:String
    var name:String
    var phone:String
    
 
   
}

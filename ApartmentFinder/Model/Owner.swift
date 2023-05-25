//
//  Owner.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 4/13/23.
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

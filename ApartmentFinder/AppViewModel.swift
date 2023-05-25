//
//  AppViewModel.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 3/30/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppViewModel:ObservableObject{
    let auth=Auth.auth()
    
    @State var owner: Owner?
    
    @Published var userName : String = ""
    
    @Published var studentUserName : String = ""
    
    @Published var apartments = [Apartment]()
    
    @Published var signedIn = false
    
    @Published var studentSignedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email:String,password:String){                                                      //called when Owner clicks on SignIn button
        auth.signIn(withEmail: email, password: password){ [weak self] result,error in
            guard result != nil,error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.signedIn=true
            }
        }
    }
    
    func studentSignIn(email:String,password:String){                                                 //called when Student clicks on SignIn button
        auth.signIn(withEmail: email, password: password){ [weak self] result,error in
            guard result != nil,error == nil else{
                return
            }
            //success
            DispatchQueue.main.async {
                self?.studentSignedIn=true
            }
        }
    }

    
    func signUp(email:String,password:String,name:String,phone:String){                            //Called when Owner creates a new account by clicking on create button
        auth.createUser(withEmail:  email, password: password) { [weak self] result ,error in
            guard result != nil,error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn=true
                self?.storeUserInformation(email:email,name:name,phone:phone)
            }
        }
    }
    
    func studentSignUp(email:String,password:String,name:String){                                //Called when Student creates a new account by clicking on create button
        auth.createUser(withEmail:  email, password: password) { [weak self] result ,error in
            guard result != nil,error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.studentSignedIn=true
                self?.storeStudentUserInformation(email:email,name:name)
            }
        }
    }
    
    func signOut() {                                                                            //Called when sign out button clicked
        try? auth.signOut()
        self.signedIn=false
        self.studentSignedIn = false
    }
    
    func storeUserInformation(email:String,name:String,phone:String) {                      //called for storing owner credentials
          guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["name": name, "email": email,"phone":phone, "uid": uid]
          Firestore.firestore().collection("users")
              .document(uid).setData(userData) { err in
                  if let err = err {
                      print(err)
                      
                      return
                  }
   
                  print("Success")
              }
      }
    
    func storeStudentUserInformation(email:String,name:String) {                        //called for storing student credentials
         guard let uid = Auth.auth().currentUser?.uid else { return }
         let suserData = ["name": name, "email": email, "uid": uid]
         Firestore.firestore().collection("studentUsers")
             .document(uid).setData(suserData) { err in
                 if let err = err {
                     print(err)
                     
                     return
                 }
  
                 print("Success")
             }
     }
    
    func getLoggedInUserName(){                                                 //called to authorize the credentials enterd by the owner
        var username:String=""
        
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users")
            .document(uid).getDocument{ document,err in
              
              let data = document?.data()
                DispatchQueue.main.async {
                    username  = data?["name"] as? String ?? ""
                    self.userName = username
                    
                }
            }
        }
    //
   

    func getLoggedInOwnerInfo(ownerID: String, completion: @escaping (Owner?, Error?) -> Void) {            //called to get information of the owner
        let db = Firestore.firestore()
        let ownerRef = db.collection("owners").document(ownerID)
        
        ownerRef.getDocument { document, error in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists {
                let data = document.data()
                let owner = Owner(id: data!["uid"] as? String ?? "", email: data!["email"] as? String ?? "", name: data!["name"] as? String ?? "",phone: data!["phone"] as? String ?? "")
                completion(owner, nil)
            } else {
                completion(nil, nil)
            }
        }
    }

    //
    

    
    func getLoggedInStudentUserName(){                                              //called to authorize the credentials enterd by the owner
        var studentUsername:String=""
        
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("studentUsers")
            .document(uid).getDocument{ document,err in
              
              let data = document?.data()
                DispatchQueue.main.async {
                    studentUsername  = data?["name"] as? String ?? ""
                    self.studentUserName  = studentUsername
                    
                }
            }
        }
   

   
   
    func getStudentAllApartments() {                                                          //called when a student is logged to display all apartments listed
        Firestore.firestore().collection("apartments").addSnapshotListener(){ querySnapshot, error in
            if error==nil{
                if let snapshot=querySnapshot{
                    DispatchQueue.main.async {
                        self.apartments = snapshot.documents.map { document in
                            let latitude = document["latitude"] as? Double ?? 0.0
                            let longitude = document["longitude"] as? Double ?? 0.0
                            
                            return Apartment(id: document.documentID,
                                             location: document["location"] as? String ?? "",
                                             price: document["price"] as? String ?? "",
                                             description: document["description"] as? String ?? "",
                                             images: document["images"] as? [String] ?? [],
                                             ownerId: document["ownerId"] as? String ?? "",
                                             latitude: latitude,
                                             longitude: longitude)
                        }
                    }
                }
            }else{
                print(error as Any)
            }

                }
            }
    
    func getAllApartments() {                                       //called when an owner is logged to display all apartments added by owner
        guard let currentUser = auth.currentUser else {
            return
        }
        
        Firestore.firestore().collection("apartments")
            .whereField("ownerId", isEqualTo: currentUser.uid)
            .addSnapshotListener(){ querySnapshot, error in
                if error==nil{
                    if let snapshot=querySnapshot{
                        DispatchQueue.main.async {
                            self.apartments = snapshot.documents.map { document in
                                let latitude = document["latitude"] as? Double ?? 0.0
                                let longitude = document["longitude"] as? Double ?? 0.0
                                
                                return Apartment(id: document.documentID,
                                                 location: document["location"] as? String ?? "",
                                                 price: document["price"] as? String ?? "",
                                                 description: document["description"] as? String ?? "",
                                                 images: document["images"] as? [String] ?? [],
                                                 ownerId: document["ownerId"] as? String ?? "",
                                                 latitude: latitude,
                                                 longitude: longitude)
                            }

                        }
                    }
                }else{
                    print(error as Any)
                }
            }
    }
    
    
    
    func addApartment(description: String, address: String, price: String, images: [String], completion: ((Error?) -> Void)? = nil) {   //called when apartment is added by owner
        guard let currentUser = auth.currentUser else {
            let error = NSError(domain: "com.hasnain.ApartmentFinder", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not signed in"])
                    completion?(error)
                    return
        }
        
        let data: [String: Any] = [
            "description": description,
            "location": address,
            "price": price,
            "images": images,
            "ownerId": currentUser.uid
        ]
      
        
        let apartmentsCollection = Firestore.firestore().collection("apartments")          //all apartments added are stored by calling this function
        apartmentsCollection.addDocument(data: data) { error in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }
}


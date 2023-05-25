//
//  ApartmentFinderApp.swift
//  ApartmentFinder
//
//  Created by Romil Jain on 3/30/23.
//

import SwiftUI
import Firebase

@main
struct ApartmentFinderApp: App {
    
   @UIApplicationDelegateAdaptor(AppDelegate.self)  var appdelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the photo library observer
        _ = PhotoLibraryObserver.shared
        return true
    }

    // Add other AppDelegate methods if needed
}
//
//  AppDelegate.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


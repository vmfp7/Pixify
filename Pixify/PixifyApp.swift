//
//  PixifyApp.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//

import SwiftUI

@main
struct PixifyApp: App {
    // Register the AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            PhotoGalleryView()
        }
    }
}

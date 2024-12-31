//
//  ContentView.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Photo Organizer")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: PhotoGalleryView()) {
                    Text("View Photos")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct PhotoViewer: View {
    var photo: Photo
    @Binding var photos: [Photo]
    @Binding var selectedPhoto: Photo?

    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(photos.indices, id: \.self) { index in
                    Image(uiImage: photos[index].image)
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                        .onTapGesture {
                            selectedPhoto = nil
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                if let index = photos.firstIndex(of: photo) {
                    currentIndex = index
                }
            }

            HStack {
                Spacer()
                Button(action: {
                    deleteCurrentPhoto()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                }
                .padding()
            }
        }
    }

    private func deleteCurrentPhoto() {
        let photoToDelete = photos[currentIndex]
        PhotoStorage.shared.deleteImage(withName: photoToDelete.filename)

        photos.remove(at: currentIndex)

        if photos.isEmpty {
            selectedPhoto = nil
        } else {
            if currentIndex >= photos.count {
                currentIndex = photos.count - 1
            }
        }
    }
}
//
//  PhotoViewer.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


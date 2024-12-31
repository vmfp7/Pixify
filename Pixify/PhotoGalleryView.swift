import SwiftUI
import PhotosUI

struct PhotoGalleryView: View {
    @State private var photos: [Photo] = []
    @State private var isImagePickerPresented = false
    @State private var selectedPhoto: Photo? = nil
    @State private var isPhotoViewerPresented = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(photos, id: \.id) { photo in
                        Image(uiImage: photo.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .onTapGesture {
                                selectedPhoto = photo
                                isPhotoViewerPresented = true
                            }
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(photos: $photos)
            }
            .sheet(item: $selectedPhoto) { photo in
                PhotoViewer(photo: photo, photos: $photos, selectedPhoto: $selectedPhoto)
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Import Photos")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Photo Gallery")
        .onAppear {
            loadSavedImages()
            NotificationCenter.default.addObserver(forName: .newPhotoImported, object: nil, queue: .main) { _ in
                loadSavedImages()
            }
        }
    }

    private func loadSavedImages() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURLs = try? fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)

        photos = fileURLs?.compactMap { url in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                return Photo(image: image, filename: url.lastPathComponent)
            }
            return nil
        } ?? []
    }
}

struct PhotoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalleryView()
    }
}
//  PhotoGalleryView.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


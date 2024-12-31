import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var photos: [Photo]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                        if let image = object as? UIImage {
                            DispatchQueue.main.async {
                                let filename = UUID().uuidString
                                PhotoStorage.shared.saveImage(image, withName: filename)
                                self?.parent.photos.append(Photo(image: image, filename: filename))
                            }
                        }
                    }
                }
            }
        }
    }
}
//  ImagePicker.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


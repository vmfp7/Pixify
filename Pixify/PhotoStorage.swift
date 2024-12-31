import UIKit

class PhotoStorage {
    static let shared = PhotoStorage()
    private init() {}

    func saveImage(_ image: UIImage, withName name: String) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
        }
    }

    func loadImage(withName name: String) -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        if let data = try? Data(contentsOf: filename) {
            return UIImage(data: data)
        }
        return nil
    }

    func deleteImage(withName name: String) {
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        try? FileManager.default.removeItem(at: filename)
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
//
//  PhotoStorage.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


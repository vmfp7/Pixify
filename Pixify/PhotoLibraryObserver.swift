import Photos

class PhotoLibraryObserver: NSObject, PHPhotoLibraryChangeObserver {
    static let shared = PhotoLibraryObserver()

    private override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            self.handleLibraryChange(changeInstance: changeInstance)
        }
    }

    private func handleLibraryChange(changeInstance: PHChange) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        allPhotos.enumerateObjects { (asset, index, stop) in
            if let changeDetails = changeInstance.changeDetails(for: asset) {
                if changeDetails.objectWasDeleted {
                    // Handle deleted photos if necessary
                } else if changeDetails.assetContentChanged {
                    self.importNewPhoto(asset: asset)
                }
            }
        }
    }

    private func importNewPhoto(asset: PHAsset) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat

        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, info in
            guard let image = image else { return }
            let filename = UUID().uuidString
            PhotoStorage.shared.saveImage(image, withName: filename)

            // Notify the main view to update the photo gallery
            NotificationCenter.default.post(name: .newPhotoImported, object: nil)
        }
    }
}

extension Notification.Name {
    static let newPhotoImported = Notification.Name("newPhotoImported")
}
//
//  PhotoLibraryObserver.swift
//  Pixify
//
//  Created by Victor Manuel Flores Perez on 12/29/24.
//


//
//  LibraryPicker.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-11-13.
//

import Foundation
import SwiftUI
import PhotosUI

@available(iOS 14, *)
struct LibraryPicker: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LibraryPicker>) -> some UIViewController {
        
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: LibraryPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<LibraryPicker>) { }
    
    func makeCoordinator() -> LibraryPicker.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        
        var parent: LibraryPicker
        
        init(parent: LibraryPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            if results.count != 1{
                return
            }
            
            if let image = results.first{
                if image.itemProvider.canLoadObject(ofClass: UIImage.self){
                    image.itemProvider.loadObject(ofClass: UIImage.self){image, error in
                        
                        guard error == nil else{
                            print(#function, error!.localizedDescription)
                            return
                        }
                        
                        if let image = image{
                            let identifiers = results.compactMap(\.assetIdentifier)
                            let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
                            let imageMetaData = fetchResults[0]
                            print(#function, "metadata : \(imageMetaData.creationDate!)")
                            print(#function, "metadata : \(imageMetaData.isFavorite)")
                            
                            self.parent.selectedImage = image as? UIImage
                        }
                    }
                }
            }
            
            self.parent.isPresented.toggle()
        }
    }
}

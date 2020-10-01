//
//  VideoPicker.swift
//  videoprocess
//
//  Created by Mik on 01/10/2020.
//
import UIKit
import SwiftUI

// Inspiration : https://github.com/appcoda/ImagePickerSwiftUI/
struct VideoPicker: UIViewControllerRepresentable {

    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Binding var selectedUrl: URL?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPicker>) -> UIImagePickerController {
 
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = context.coordinator
        imagePickerController.mediaTypes = ["public.movie"]
        return imagePickerController
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<VideoPicker>) {
 
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: VideoPicker
     
        init(_ parent: VideoPicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            /* if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selected = image
            } */
            if let url = info[UIImagePickerController.InfoKey(rawValue: convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL))] as? URL {
                parent.selectedUrl = url
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
            return input.rawValue
        }
    }

}


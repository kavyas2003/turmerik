


//
//  ImagePicker.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    //    @State private var image : UIImage = UIImage()
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //            if image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //                parent.selectedImage = image
            //            }
            let  image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            parent.selectedImage = image
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    //    static func getImageAsString() -> String
    //    {
    //        let data = self.selectedImage.jpegData(compressionQuality: 1.0)
    //        let strBase64 = (data?.base64EncodedString(options: .lineLength64Characters))!
    //        return strBase64
    //    }
    //
    //    static func getImage() -> UIImage {
    //        return self.selectedImage
    //    }
}



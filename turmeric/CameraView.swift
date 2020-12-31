//
//  CameraView.swift
//  turmeric
//
//  Created by kavya sriram on 7/19/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
}


//
//  CameraView.swift
//  turmeric
//
//  Created by kavya sriram on 7/19/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI


struct CameraView: View {
 
    @State private var isShowPhotoLibrary = false
    @Binding  var photoImage:UIImage
    @State var showingAdd = false
 //   @State var med:Medicine
 
    var body: some View {
        VStack {

            ImagePicker(sourceType: .photoLibrary, selectedImage: $photoImage)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
}

/*extension CameraView {
    init(frommed med:Medicine) {
        photoImage = med.getPicture()
        showingAdd = false
        isShowPhotoLibrary = false
    }
}*/
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}




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
    @State private var image = UIImage()
    @State var showingAdd = false
 
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
            self.showingAdd.toggle()
            }) {
                Text("Cancel")
            }.sheet(isPresented: self.$showingAdd) {
                        AddMedicineView()
                    }
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
 
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
 
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}



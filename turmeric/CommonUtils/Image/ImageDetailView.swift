//
//  ImageDetail.swift
//  turmeric
//
//  Created by sriram palapudi on 11/17/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct ImageDetailView: View {
    @State var showingImageDetail:Bool
    @State var picture:UIImage
    
    var body: some View {
        VStack {
//            ScrollView {
                Image(uiImage: self.picture)
                    .resizable()
                    .frame(width: 400, height: 500)
//                    .clipShape(Circle())
                     .shadow(radius: 10)
            }
//        }
    }
}



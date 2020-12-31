


//
//  MedicineImage.swift
//  testproject1000
//
//  Created by kavya sriram on 6/16/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct MedicineImage: View {
    var body: some View {
        Image("albuterol")
            .clipShape(Circle())
            .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
    }
}

struct MedicineImage_Previews: PreviewProvider {
    static var previews: some View {
        MedicineImage()
    }
}


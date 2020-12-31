//
//  MedicineEdit.swift
//  turmeric
//
//  Created by kavya sriram on 10/11/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
import SwiftUI

struct MedicineEdit: View {
@Binding var medicine: Medicine
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $medicine.name)
            }
        }
    }
}

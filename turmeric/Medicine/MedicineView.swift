//
//  MedicineView.swift
//  turmeric
//
//  Created by sriram palapudi on 9/14/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct MedicineView: View {
    var med:Medicine
    var body: some View {
        VStack{
            Text("Hello, World! see medicine \(med.getName())")
            Text("Hello, World! see medicine \(med.getName())")
            Text("Hello, World! see medicine \(med.getName())")
        }
    }
}

struct MedicineView_Previews: PreviewProvider {
    static var previews: some View {
        let med1 = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "square.and.pencil",schedule:MedicineSchedule(), startdate: "", enddate: "", totalcount: 1, expirydate: "", ingredientsUrl: "")
        return MedicineView(med:med1)
    }
}

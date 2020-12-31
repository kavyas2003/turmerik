//
//  AddView.swift
//  testproject1000
//
//  Created by kavya sriram on 6/20/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct AddMedicineView: View {
    @State var showingHome = false
    @State var isToggle: Bool = false
    @State var showingCamera = false
    @State private var meddates = Date()
    @State var name = ""
    @State var dosage = ""
    @State var dosagetype = ""
    @State var medicinetype = ""
    @State var prescription = ""
    @State var dos = 0
    @State var prescriptionval = 0
    @State var purchaseinfo = ""
    
    
    var body: some View {
        VStack{
            HStack{
                //cancel button
                Button(action: {
                    self.showingHome.toggle()
                    }) {
                    Text("Cancel")
                    }.sheet(isPresented: $showingHome) {
                        HomeView()
                }
                Spacer()
                Text("Add Medicine")
            }
                TextField("Medicine Name", text: $name)
                TextField("Dosage Type", text: $dosagetype)
                TextField("Medicine Dosage", text: $dosage)
                    .keyboardType(.decimalPad)
                TextField("Medicine Type", text: $medicinetype)
                TextField("Prescription", text: $prescription)
                TextField("Purchase Info", text: $purchaseinfo)
                //Text("Enter a Date")
                DatePicker("", selection: $meddates)
                //TextField("Additional Comments", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            // camera button
                Button(action: {
                    self.showingCamera.toggle()
                    }) {
                    Text("Add image")
                    }.sheet(isPresented: $showingCamera) {
                        CameraView()
                }
            // add button
                Button(action: {
                    self.showingHome.toggle()
                    var db : OpaquePointer
                    db = DButils.openDatabase()!

                    let dropTableString = """
                        drop table Medicine;
                     """
                    DButils.dropTable(db:db, dropTableString : dropTableString)
                    let createTableString = """
                        CREATE TABLE Medicine(
                        name CHAR(255),
                        dosage INT,
                        dosageType CHAR(255),
                        type CHAR(255),
                        prescription INT,
                        purchaseinfo CHAR(255));
                        """
                    DButils.createTable(db: db, createTableString: createTableString)
                    let dosagearray = self.dosage.split(separator: " ")
                    for item in dosagearray {
                        let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

                        if let intVal = Int(part) {
                            print("this is a number -> \(intVal)")
                            self.dos = intVal
                        }
                    }
                    if self.prescription == "Yes" {
                        self.prescriptionval = 1
                    } else{
                        self.prescriptionval = 0
                    }
                    MedicineHelper.addMedicine(name: self.name as NSString, dosage: self.dos, dosageType: self.dosagetype as NSString, type: self.medicinetype as NSString, prescription: self.prescriptionval, purchaseinfo: self.purchaseinfo as NSString)
                        }) {
                        Text("Add")
                    }.sheet(isPresented: self.$showingHome) {
                        HomeView()
            }
        }
    }
}

struct AddMedicineView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicineView()
    }
}


//
//  Medicine.swift
//  testproject1000
//
//  Created by kavya sriram on 5/30/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation

class Medicine {
    
    var name : String //
    var dosage :Int //
    var dosageType :  String //
    var type : Int //
    var prescription : Int //
    var purchaseinfo : String //
    var activeingredients : String //
    var passiveingredients : String //

    
    init(name : String, dosage: Int, dosageType: String, type: Int ,prescription: Int, purchaseinfo: String) {
        self.name = name
        self.dosage = dosage
        self.dosageType = dosageType
        self.type = type
        self.prescription = 0;
        self.passiveingredients = ""
        self.activeingredients = ""
        self.purchaseinfo = purchaseinfo
    }
    
    func getName() -> String {
        return name;
    }
    
    func getDosage() -> Int {
        return dosage;
    }
    
    func getDosageType() -> String {
        return dosageType;
    }
    
    func getType() -> Int {
        return type;
    }
    
    func getPrescription() -> Int {
        return prescription;
    }
    
    func getPurchaseinfo() -> String {
        return purchaseinfo;
    }
    
    

}


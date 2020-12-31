//
//  Medicine.swift
//  testproject1000
//
//  Created by kavya sriram on 5/30/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import Foundation
import UIKit

class Medicine : Identifiable, Equatable {
    //@Published var medicine = Medicine.default
    
    var name : String //
    var dosage :Int //
    var dosageType :  String //
    var type : String //
    var prescription : String //
    var purchaseinfo : String //
    var pictureUrl : String //
    var schedule : MedicineSchedule //
    var activeingredients : String //
    var passiveingredients : String //
    var startdate : String // Date when the medication starts. To be used for display in today list if active
    var enddate : String // Date when the medication ends. To be used for display in today list if active
    var totalcount : Int // Total count of medication (useful for medicines that are not taken on a schedule but notify if the medication is about to end
    var expirydate : String // To be used to notify when a expiry date is being reached.
    var ingredientsUrl: String
    var picture: UIImage = UIImage()
    var ingredientsPicture: UIImage = UIImage()
    
    
    init() {
        self.name = "Enter Medicine Name"
        self.dosage = 1
        self.dosageType = "Pills"
        self.type = "Allergy"
        self.prescription = ""
        self.passiveingredients = ""
        self.activeingredients = ""
        self.purchaseinfo = ""
        self.pictureUrl = ""
        self.schedule = MedicineSchedule()
        self.startdate = ""//Date()
        self.enddate = ""//Calendar.current.date(byAdding: duration, to: startdate)!
        self.expirydate = ""
        self.totalcount = 100
        self.ingredientsUrl = ""
    }
    
    init(name : String, dosage: Int, dosageType: String, type: String ,prescription: String, purchaseinfo: String, pictureUrl: String, schedule : MedicineSchedule, startdate:String, enddate:String, totalcount: Int, expirydate: String, ingredientsUrl: String) {
        self.name = name
        self.dosage = dosage
        self.dosageType = dosageType
        self.type = type
        self.prescription = prescription
        self.passiveingredients = ""
        self.activeingredients = ""
        self.purchaseinfo = purchaseinfo
        self.pictureUrl = pictureUrl
        self.schedule = schedule
        //Need to pass this information as part of the init
        self.startdate = startdate//Date()
        self.enddate = enddate//Calendar.current.date(byAdding: duration, to: startdate)!
        self.expirydate = expirydate
        self.totalcount = totalcount
        self.ingredientsUrl = ingredientsUrl
    }
    
    static func ==(lhs: Medicine, rhs: Medicine) -> Bool {
        return lhs.name == rhs.name
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
    
    func getType() -> String {
        return type;
    }
    
    func getPrescription() -> String {
        return prescription;
    }
    
    func getPurchaseinfo() -> String {
        return purchaseinfo;
    }
    
    func getMedicineImage() -> UIImage {
        let imageBase64String = pictureUrl
        var picture = UIImage(systemName: "camera")
        if !imageBase64String.starts(with: GlobalConstants.EMPTY) {
            let imageData = FileUtils.readDataFromFile(filename: imageBase64String, namedValue:"camera")
            picture = UIImage(data: imageData)
        }
        return picture!
    }
    func getIngredientsImage() -> UIImage {
        let imageBase64String = ingredientsUrl
        var picture = UIImage(systemName: "camera")
        if !imageBase64String.starts(with: GlobalConstants.EMPTY) {
            let imageData = FileUtils.readDataFromFile(filename: imageBase64String, namedValue:"camera")
            picture = UIImage(data: imageData)
        }
        return picture!
    }

    func getPictureUrl() -> String {
        return pictureUrl
    }
    
    func getIngredientsUrl() -> String {
        return ingredientsUrl
    }
//    func getPictureUrl() -> URL {
//        let url = FileUtils.getFilePath(filename: picture)
//        return url
//    }
    
    func getSchedule() -> MedicineSchedule {
        return schedule
    }
    
    func getActiveIngredients() -> String {
        return activeingredients
    }
    
    func getPassiveIngredients() -> String
    {
        return passiveingredients
    }
    
    func getTimesList() -> MedicineTimesList {
        return schedule.getTimesList()
    }
    
    func getStartDate()-> String{
        return startdate
    }
    func getEndDate()-> String{
    return enddate
    }
    func getTotalCount()-> Int{
    return totalcount
    }
    func getExpiryDate()-> String{
    return expirydate
    }

}

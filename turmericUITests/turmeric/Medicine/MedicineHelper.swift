//
//  Utilities.swift
//  testproject1000
//
//  Created by kavya sriram on 5/30/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import Foundation
import SQLite3

class MedicineHelper {
    
    static func medquery(db: OpaquePointer, queryStatementString: String) -> [String]? {
      var medarray = [String]()
      var queryStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, queryStatementString,
        -1,
        &queryStatement,
        nil
      ) == SQLITE_OK {
        print("\n")
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
          guard let queryResultCol0 = sqlite3_column_text(queryStatement, 0) else {
            print("Query result is nil.")
            return nil
          }
            guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else{
                return nil
            }
            guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                return nil
            }
            guard let queryResultCol5 = sqlite3_column_text(queryStatement, 5) else {
                return nil
            }
         let name = String(cString: queryResultCol0)
         let dosage = sqlite3_column_int(queryStatement, 1)
         let dosageType = String(cString: queryResultCol2)
         let type = String(cString: queryResultCol3)
         let prescription = sqlite3_column_int(queryStatement, 4)
         let purchaseinfo = String(cString: queryResultCol5)
         

          print("Query Result:")
          print("\(name), \(dosage), \(dosageType), \(type), \(prescription), \(purchaseinfo)")
          let medicine = ("\(name), \(dosage), \(dosageType), \(type), \(prescription), \(purchaseinfo)")
            medarray.append(medicine)
            print("medarray: \(medarray)")
        }
        } else {
          let errorMessage = String(cString: sqlite3_errmsg(db))
          print("\nQuery is not prepared \(errorMessage)")
      }
      sqlite3_finalize(queryStatement)
      return medarray
    }

    
    static func getallmedicine () -> [Medicine] {
        let queryStatementString = "SELECT * FROM Medicine;"
        var mArr = [Medicine]()
        var db : OpaquePointer
        db = DButils.openDatabase()!
     
        let queryarray = medquery(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("m: \(m)")
            let nameVal = m[0]
            let dosageVal = Int(m[1]) ?? 0
            let dosageTypeVal = m[2]
            let typeVal = Int(m[3]) ?? 0
            let prescriptionVal = Int(m[4]) ?? 0
            let purchaseinfoVal = m[5]
            //let prescriptionVal = Int(m[5]) ?? 0
            let med = Medicine(name: nameVal, dosage: dosageVal , dosageType: dosageTypeVal, type: typeVal, prescription: prescriptionVal, purchaseinfo: purchaseinfoVal)
          //  print("name\(nameVal)")
 //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
            mArr.append(med)
            print("med.name:\(med.getName())")
        }
     //   print("mArr: \(mArr)")
        // Call Query with right query
   
        //Create the Medicine Array and return it.

        // Create a for loop and in that for loop add medicines and return
        return mArr
    }
    
    //func getMedicine () -> (Medicine) {
      //  let queryStatementString = "SELECT * FROM Medicine;"
        //var db : OpaquePointer
        //db = openDatabase()!
        //var queryarray = query(db:db, queryStatementString: queryStatementString )
        //var m = queryarray?[0]
        //m = queryarray[0].components(separatedBy: ", ")
        //m = newMedicine
        //return m
    //}
    
    static func addMedicine (name: NSString, dosage: Int, dosageType: NSString, type: NSString, prescription: Int, purchaseinfo: NSString){
        let insertStatementString = "INSERT INTO Medicine (name, dosage, dosageType, type, prescription, purchaseinfo) VALUES ('\(name)',\(dosage),'\(dosageType)','\(type)', \(prescription), '\(purchaseinfo)');"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        DButils.insert(db: db,insertStatementString: insertStatementString)
//        let temp = "SELECT * FROM Medicine WHERE id = (SELECT MAX(id) FROM Medicine);"
//        print("HERE!!!!!!!")
//        print(query(db:db, queryStatementString: temp));
    }
    
    static func removeMedicine (name: String) {
        let delname = name
        let deleteStatementString = "DELETE FROM Medicine WHERE name like '\(delname)';"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        DButils.delete(db:db, deleteStatementString: deleteStatementString )
    }


}

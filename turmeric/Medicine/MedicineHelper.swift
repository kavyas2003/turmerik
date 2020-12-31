//
//  Utilities.swift
//  testproject1000
//
//  Created by kavya sriram on 5/30/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import Foundation
import SQLite3
import UserNotifications

class MedicineHelper {
    
    static func medQuery(db: OpaquePointer, queryStatementString: String) -> [String]? {
        var medarray = [String]()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString,
                              -1,
                              &queryStatement,
                              nil
            ) == SQLITE_OK {
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
                guard let queryResultCol4 = sqlite3_column_text(queryStatement, 4) else {
                    return nil
                }
                guard let queryResultCol5 = sqlite3_column_text(queryStatement, 5) else {
                    return nil
                }
                guard let queryResultCol6 = sqlite3_column_text(queryStatement, 6) else {
                    return nil
                }
                guard let queryResultCol7 = sqlite3_column_text(queryStatement, 7) else {
                    return nil
                }
                guard let queryResultCol8 = sqlite3_column_text(queryStatement, 8) else {
                    return nil
                }
                guard let queryResultCol9 = sqlite3_column_text(queryStatement, 10) else {
                    return nil
                }
                guard let queryResultCol10 = sqlite3_column_text(queryStatement, 11) else {
                    return nil
                }
                
                
                let name = String(cString: queryResultCol0)
                let dosage = sqlite3_column_int(queryStatement, 1)
                let dosageType = String(cString: queryResultCol2)
                let type = String(cString: queryResultCol3)
                let prescription = String(cString: queryResultCol4)
                let purchaseinfo = String(cString: queryResultCol5)
                let picture = String(cString: queryResultCol6)
                let startDate = String(cString: queryResultCol7)
                let endDate = String(cString: queryResultCol8)
                let totalcount = sqlite3_column_int(queryStatement, 9)
                let expirydate = String(cString: queryResultCol9)
                let ingredients = String(cString: queryResultCol10)
                // Get the schedule object created and populate by the data from the database using medquery again.
                let medicine = ("\(name), \(dosage), \(dosageType), \(type), \(prescription), \(purchaseinfo), \(picture), \(startDate), \(endDate), \(totalcount), \(expirydate), \(ingredients)")
                medarray.append(medicine)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return medarray
    }
    
    static func medScheduleQuery(db: OpaquePointer, name: String) -> MedicineSchedule? {
        
        let queryStatementString = "Select * from medschedule where name = '\(name)'"
        let medicineSchedule = MedicineSchedule()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString,
                              -1,
                              &queryStatement,
                              nil
            ) == SQLITE_OK {
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else{
                    return nil
                }
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    return nil
                }
                
                var scheduleRow:[String] = []
                let day = String(cString: queryResultCol1)
                let time = String(cString: queryResultCol2)
                scheduleRow.append(day)
                scheduleRow.append(time)
                medicineSchedule.addDaysTimesToSchedule(row: scheduleRow)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return medicineSchedule
    }
    
    static func getAllMedicine () -> [Medicine] {
        let queryStatementString = "SELECT * FROM Medicine;"
        var mArr = [Medicine]()
        var db : OpaquePointer
        db = DButils.openDatabase()!
        
        let queryarray = medQuery(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("Get All Medicine \(m)")
            let nameVal = m[0]
            let dosageVal = Int(m[1]) ?? 0
            let dosageTypeVal = m[2]
            let typeVal = m[3]
            let prescriptionVal = m[4]
            let purchaseinfoVal = m[5]
            let pictureVal = m[6]
            let startdateval = m[7]
            let enddateval = m[8]
            let totalcountval = Int(m[9]) ?? 0
            let expirydateval = m[10]
            let ingredientsval = m[11]
            let schedule = medScheduleQuery(db: db, name: nameVal)
            //KAVYA TBA
            //for loop for looking through each row and add it to the schedule object.
            //Get the data for schedule and create a schedule object and use it to initialze the med.
            //let prescriptionVal = Int(m[5]) ?? 0
            let med = Medicine(name: nameVal, dosage: dosageVal , dosageType: dosageTypeVal, type: typeVal, prescription: prescriptionVal, purchaseinfo: purchaseinfoVal, pictureUrl: pictureVal,schedule:schedule!, startdate: startdateval, enddate: enddateval, totalcount: totalcountval, expirydate: expirydateval, ingredientsUrl: ingredientsval)
            mArr.append(med)
        }

        return mArr
    }
    
    static func getMedicine (name:String) -> Medicine {
        let queryStatementString = "SELECT * FROM Medicine where name = '\(name)';"
        var medicine = Medicine(name: GlobalConstants.EMPTY, dosage: 0, dosageType: "", type: "", prescription: "", purchaseinfo: "", pictureUrl: "",schedule: MedicineSchedule(), startdate: "", enddate: "", totalcount: 1, expirydate: "", ingredientsUrl:"")
        //var medicine:Medicine
        var db : OpaquePointer
        db = DButils.openDatabase()!
        
        let queryarray = medQuery(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("GetMedicine \(m)")
            let nameVal = m[0]
            let dosageVal = Int(m[1]) ?? 0
            let dosageTypeVal = m[2]
            let typeVal = m[3]
            let prescriptionVal = m[4]
            let purchaseinfoVal = m[5]
            let pictureVal = m[6]
            let startdateval = m[7]
            let enddateval = m[8]
            let totalcountval = Int(m[9]) ?? 0
            let expirydateval = m[10]
            let ingredientsval = m[11]
            //let prescriptionVal = Int(m[5]) ?? 0
            let schedule = medScheduleQuery(db: db, name: nameVal)
            
            //KAVYA TBA
            //for loop for looking through each row and add it to the schedule object.
            //Get the data for schedule and create a schedule object and use it to initialze the med.
            //let prescriptionVal = Int(m[5]) ?? 0
            //Write this as a separate func so that you can use the same in the getAllMedicine too.
            medicine = Medicine(name: nameVal, dosage: dosageVal , dosageType: dosageTypeVal, type: typeVal, prescription: prescriptionVal, purchaseinfo: purchaseinfoVal, pictureUrl: pictureVal,schedule: schedule!, startdate: startdateval, enddate: enddateval, totalcount: totalcountval, expirydate: expirydateval, ingredientsUrl: ingredientsval)
            
            //  print("name\(nameVal)")
            //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
            print("med.name:\(medicine.getName())")
        }
        //   print("mArr: \(mArr)")
        // Call Query with right query
        
        //Create the Medicine Array and return it.
        
        // Create a for loop and in that for loop add medicines and return
        return medicine
    }
    
    static func addMedicine (medicine:Medicine){
        if getMedicine(name: medicine.name).getName() == GlobalConstants.EMPTY {
            let insertmedsStatementString = "INSERT INTO Medicine (name, dosage, dosageType, type, prescription, purchaseinfo, picture, startDate, endDate, totalcount, expirydate, ingredients) VALUES ('\(medicine.name)',\(medicine.dosage),'\(medicine.dosageType)','\(medicine.type)', '\(medicine.prescription)', '\(medicine.purchaseinfo)', '\(medicine.pictureUrl)', '\(medicine.startdate)','\(medicine.enddate)', \(medicine.totalcount),'\(medicine.expirydate)', '\(medicine.ingredientsUrl)');"
            //        let insertStatementString = "INSERT INTO Medicine (name, dosage, dosageType, type, prescription, purchaseinfo) VALUES ('\(name)',\(dosage),'\(dosageType)','\(type)', \(prescription), '\(purchaseinfo)');"
            var db : OpaquePointer
            db = DButils.openDatabase()!
            DButils.insert(db: db,insertStatementString: insertmedsStatementString)
            //KAVYA TBD Use a for loop to get the rows for days and times and add it here
            // call add schedule row
            let schedule = medicine.schedule
            let rows = schedule.getScheduleRows()
            let lm = LocalNotificationManager()
            for row in rows{
                let (dayVal, timeVal) = row
                let insertStatementString = "INSERT INTO MedSchedule (name,day,time) VALUES ('\(medicine.getName())','\(dayVal)','\(timeVal)');"
                DButils.insert(db: db,insertStatementString: insertStatementString)
                lm.addNotification(name: medicine.getName(), dayVal: dayVal, timeVal: timeVal,deferFlag: false)
            }
        } else {
            updateMedicine(medicine:medicine)
        }
    }
    
    /*
    static func getMedicineRecords(medicine : Medicine) -> [String]{
        var strArray = [String]()
        let name = medicine.getName()
        let queryStatementString = "SELECT * FROM Medicine where name = '\(name)';"
        var medicine = Medicine(name: GlobalConstants.EMPTY, dosage: 0, dosageType: "", type: "", prescription: "", purchaseinfo: "", pictureUrl: "",schedule: MedicineSchedule(), startdate: "", enddate: "", totalcount: 1, expirydate: "", ingredientsUrl:"")
        //var medicine:Medicine
        var db : OpaquePointer
        db = DButils.openDatabase()!
        
        let queryarray = medQuery(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("m: \(m)")
            let nameVal = m[0]
            let dosageVal = Int(m[1]) ?? 0
            let dosageTypeVal = m[2]
            let typeVal = m[3]
            let prescriptionVal = m[4]
            let purchaseinfoVal = m[5]
            let pictureVal = m[6]
            let startdateval = m[7]
            let enddateval = m[8]
            let totalcountval = Int(m[9]) ?? 0
            let expirydateval = m[10]
            let ingredientsval = m[11]
            //let prescriptionVal = Int(m[5]) ?? 0
            let schedule = medScheduleQuery(db: db, name: nameVal)
            
            //KAVYA TBA
            //for loop for looking through each row and add it to the schedule object.
            //Get the data for schedule and create a schedule object and use it to initialze the med.
            //let prescriptionVal = Int(m[5]) ?? 0
            //Write this as a separate func so that you can use the same in the getAllMedicine too.
            medicine = Medicine(name: nameVal, dosage: dosageVal , dosageType: dosageTypeVal, type: typeVal, prescription: prescriptionVal, purchaseinfo: purchaseinfoVal, pictureUrl: pictureVal,schedule: schedule!, startdate: startdateval, enddate: enddateval, totalcount: totalcountval, expirydate: expirydateval, ingredientsUrl: ingredientsval)
            
            //  print("name\(nameVal)")
            //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
        }
        
        return strArray
    }
  */
    
    static func removeMedicineSchedule(name:String) {
        let deleteStatementString = "DELETE FROM MedSchedule WHERE name LIKE '\(name)';"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        DButils.delete(db:db, deleteStatementString: deleteStatementString )
    }
    
    static func removeMedicineNotifications (name : String) {
//        var notificationIdentifiers:[String] = []
//        notificationIdentifiers.append(name)
         let lm = LocalNotificationManager()
         //Get all schedule rows and add the ids to be removed.
         let medicine = getMedicine(name: name)
         let schedule = medicine.getSchedule()
         var ids:[String] = []
         let rows = schedule.getScheduleRows()
         for row in rows{
             let (dayVal, timeVal) = row
             var id = name + "_" + dayVal
             let timelist = timeVal.split(separator: ":")
             if (!timelist.isEmpty) {
                 let ampmlist = timeVal.split(separator: " ")
                 let hour = timelist[0]
                 let minute = timelist[1]
                 id = id + "_" + hour +  "_" + minute
                 id = id + "_" + ampmlist[1]
                 ids.append(id)
             }
         }
         lm.removeNotifications(ids:ids)
    }
    
    static func addMedicineNotifications (name : String) {
        let medicine = getMedicine(name: name)
        let schedule = medicine.schedule
        let rows = schedule.getScheduleRows()
        let lm = LocalNotificationManager()
        for row in rows{
            let (dayVal, timeVal) = row
            lm.addNotification(name: medicine.getName(), dayVal: dayVal, timeVal: timeVal, deferFlag: false)
        }
    }
    
    static func removeMedicine (name: String) {
//        var notificationIdentifiers:[String] = []
  //      notificationIdentifiers.append(name)
        let lm = LocalNotificationManager()
        //Get all schedule rows and add the ids to be removed.
        let medicine = getMedicine(name: name)
        let schedule = medicine.getSchedule()
        var ids:[String] = []
        let rows = schedule.getScheduleRows()
        for row in rows{
            let (dayVal, timeVal) = row
            var id = name + "_" + dayVal
            let timelist = timeVal.split(separator: ":")
            if (!timelist.isEmpty) {
                let ampmlist = timeVal.split(separator: " ")
                let hour = timelist[0]
                let minute = timelist[1]
                id = id + "_" + hour +  "_" + minute
                id = id + "_" + ampmlist[1]
                ids.append(id)
            }
        }
        lm.removeNotifications(ids:ids)
        let deleteStatementString = "DELETE FROM Medicine WHERE name LIKE '\(name)';"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        DButils.delete(db:db, deleteStatementString: deleteStatementString )
        removeMedicineSchedule(name:name)
    }
    
    static func updateMedicine(medicine:Medicine) {
        removeMedicine(name: medicine.getName())
        addMedicine(medicine:medicine)
    }
    
    static func getMedicineDaySchedule() {
        //Return a array of string with name and time for the current day
    }
    
    static func createTurmericDB () {
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let createmedTableString = """
           CREATE TABLE Medicine(
           name CHAR(255),
           dosage INT,
           dosageType CHAR(255),
           type CHAR(255),
           prescription INT,
           purchaseinfo CHAR(255),
           picture Text,
           startDate CHAR(255),
           endDate CHAR(255),
           totalcount INT,
           expirydate CHAR(255),
           ingredients Text);
           """
        DButils.createTable(db: db, createTableString: createmedTableString, tableName: "Medicine", forceCreate: GlobalConstants.FORCECREATEFLAG)
        let createmeddateTableString = """
             CREATE TABLE MedSchedule(
             name CHAR(255),
             day CHAR(255),
             time CHAR(255));
             """
        
        DButils.createTable(db: db, createTableString: createmeddateTableString, tableName: "MedSchedule", forceCreate: GlobalConstants.FORCECREATEFLAG)
        let createmedrecordTableString = """
                    CREATE TABLE MedLog(
                    name CHAR(255),
                    day CHAR(255),
                    time CHAR(255),
                    medTaken CHAR(255),
                    date CHAR(255));
                    """
        
        DButils.createTable(db: db, createTableString: createmedrecordTableString, tableName: "MedLog", forceCreate: GlobalConstants.FORCECREATEFLAG)
        let createSettingsTableString = """
                           CREATE TABLE Settings(
                           user CHAR(255),
                           instructionsFlag Char(255),
                           notificationsEnabled CHAR(255),
                           showingPreviews CHAR(255));
                           """
               
               DButils.createTable(db: db, createTableString: createSettingsTableString, tableName: "Settings", forceCreate: GlobalConstants.FORCECREATEFLAG)
       
        MedicineHelper.addSettings(instructionsFlag: "true", notifcationsEnabled: "Enabled", showingPreviews: "Always", add: true)
        
        
    }
    
    static func resetMedicineTable() {
        var db : OpaquePointer
        db = DButils.openDatabase()!
        var tableName = "Medicine"
        DButils.dropTable(db: db, tableName: tableName)
        tableName = "MedSchedule"
        DButils.dropTable(db: db, tableName: tableName)
        tableName = "MedLog"
        DButils.dropTable(db: db, tableName: tableName)
        tableName = "Settings"
        DButils.dropTable(db: db, tableName: tableName)
        createTurmericDB()
    }
    
    static func addMedicineLog(medicine: String, day: String, time: String, taken: Bool){
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        let dateStr = formatter.string(from: Date())
        let deleteStatementString = "DELETE FROM MedLog WHERE name LIKE '\(medicine)' and  date LIKE '\(dateStr)' and  time LIKE '\(time)';"
        DButils.delete(db:db, deleteStatementString: deleteStatementString )
        let insertStatementString = "INSERT INTO MedLog (name, day, time, medTaken,date) VALUES ('\(medicine)','\(day)', '\(time)','\(taken)','\(dateStr)');"
        DButils.insert(db: db,insertStatementString: insertStatementString)
    }
    
    static func queryMedLogs(db: OpaquePointer, queryStatementString: String) -> [String]? {
        var recordarray = [String]()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString,
                              -1,
                              &queryStatement,
                              nil
            ) == SQLITE_OK {
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                guard let queryResultCol0 = sqlite3_column_text(queryStatement, 0) else {
                    print("Query result is nil.")
                    return nil
                }
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else{
                    return nil
                }
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    return nil
                }
                guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                    return nil
                }
                guard let queryResultCol4 = sqlite3_column_text(queryStatement, 4) else {
                    return nil
                }
                let name = String(cString: queryResultCol0)
                let dayVal = String(cString: queryResultCol1)
                let timeVal = String(cString: queryResultCol2)
                let taken = String(cString: queryResultCol3)
                let date = String(cString: queryResultCol4)

                let record = ("\(name), \(dayVal), \(timeVal), \(taken), \(date)")
                recordarray.append(record)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return recordarray
    }
    static func getMedicineLogs (med:Medicine) -> [MedicineNameTime] {
        print("getMedicineLogs Inside")
        let name = med.getName()
        let queryStatementString = "SELECT * FROM MedLog WHERE name LIKE '\(name)' order by date Desc limit 100;"
        //       let queryStatementString = "SELECT * FROM MedLog WHERE  date > date('now','-30 years');"
        //let queryStatementString = "SELECT * FROM MedLog ;"
        var rArr = [MedicineNameTime]()
        var db : OpaquePointer
        db = DButils.openDatabase()!
        
        let queryarray = queryMedLogs(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("geMedicineLogs: \(m)")
            let nameVal = m[0]
            let dayVal = m[1]
            let timeVal = m[2]
            let takenVal = m[3]
            let date =  m[4]
            //let record = MedicineLog(name:nameVal,dayVal: dayVal,timeVal: timeVal,taken: takenVal, date : date)
            let record = MedicineNameTime(name: nameVal, timeStr: timeVal, taken: Bool(takenVal)!, day: dayVal,date:date)
            
            //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
            rArr.append(record)
        }
        //   print("mArr: \(mArr)")
        // Call Query with right query
        
        //Create the Medicine Array and return it.
        
        // Create a for loop and in that for loop add medicines and return
        print("getMedicineLogs Outside")

        return rArr
    }
    
    static func getAllMedicineLogs () -> [MedicineNameTime] {
        
      
        let queryStatementString = "SELECT * FROM MedLog order by date Desc limit 100;"
        //       let queryStatementString = "SELECT * FROM MedLog WHERE  date > date('now','-30 years');"
        //let queryStatementString = "SELECT * FROM MedLog ;"
        var rArr = [MedicineNameTime]()
        var db : OpaquePointer
        db = DButils.openDatabase()!
        
        let queryarray = queryMedLogs(db:db,queryStatementString: queryStatementString)
        
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("geMedicineLogs: \(m)")
            let nameVal = m[0]
            let dayVal = m[1]
            let timeVal = m[2]
            let takenVal = m[3]
            let date =  m[4]
            //let record = MedicineLog(name:nameVal,dayVal: dayVal,timeVal: timeVal,taken: takenVal, date : date)
            let record = MedicineNameTime(name: nameVal, timeStr: timeVal, taken: Bool(takenVal)!, day: dayVal,date:date)
            
            //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
            rArr.append(record)
        }
        //   print("mArr: \(mArr)")
        // Call Query with right query
        
        //Create the Medicine Array and return it.
        
        // Create a for loop and in that for loop add medicines and return
       

        return rArr
    }
    
    static func getMedicineLog (name: String, date: String, time: String) -> MedicineNameTime {
        print("getMedicineLog Inside")
        let queryStatementString = "SELECT * FROM MedLog WHERE name LIKE '\(name)' and  date LIKE '\(date)' and  time LIKE '\(time)' limit 1;"
        //       let queryStatementString = "SELECT * FROM MedLog WHERE  date > date('now','-30 years');"
        //let queryStatementString = "SELECT * FROM MedLog ;"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let queryarray = queryMedLogs(db:db,queryStatementString: queryStatementString)
        var record = MedicineNameTime()
        for row in queryarray! {
            let m = row.components(separatedBy: ", ")
            print("getMedicineLog \(m)")
            let nameVal = m[0]
            let dayVal = m[1]
            let timeVal = m[2]
            let takenVal = m[3]
            let date = m[4]
            //let record = MedicineLog(name:nameVal,dayVal: dayVal,timeVal: timeVal,taken: takenVal, date : date)
            record = MedicineNameTime(name: nameVal, timeStr: timeVal, taken: Bool(takenVal)!, day: dayVal, date:date)
        }
        //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
        // Call Query with right query
        
        //Create the Medicine Array and return it.
        
        // Create a for loop and in that for loop add medicines and return
        print("getMedicineLog Outside")

        return record
    }
    static func updateMedicine(med: Medicine){
        var medarray = [Any]()
        let name = med.name
        var db : OpaquePointer
        db = DButils.openDatabase()!
        medarray.append(med.dosage)
        medarray.append(med.dosageType)
        medarray.append(med.type)
        medarray.append(med.prescription)
        medarray.append(med.purchaseinfo)
        medarray.append(med.getMedicineImage())
        medarray.append(med.startdate)
        medarray.append(med.enddate)
        medarray.append(med.totalcount)
        medarray.append(med.expirydate)
        medarray.append(med.ingredientsUrl)
        for item in medarray{
            let updateStatementString = "UPDATE Medicine SET dosage = '\(item)' WHERE name = '\(name)';"
            DButils.update(db:db, updateStatementString: updateStatementString)
        }
        let deleteStatementString = "DELETE * FROM MedSchedule where name like '\(name)';"
        DButils.delete(db:db, deleteStatementString:deleteStatementString)
    }
    
    static func addSettings(instructionsFlag: String, notifcationsEnabled: String, showingPreviews: String, add: Bool){
        let user = ""
        var db : OpaquePointer
        db = DButils.openDatabase()!
        if add == true{
            let deleteSettingsString = "DELETE FROM Settings;"
            DButils.delete(db:db, deleteStatementString: deleteSettingsString)
            let insertSettingsStatementString = "INSERT INTO Settings (user, instructionsFlag, notificationsEnabled, showingPreviews) VALUES ('\(user)','\(instructionsFlag)','\(notifcationsEnabled)','\(showingPreviews)');"
            //        let insertStatementString = "INSERT INTO Medicine (name, dosage, dosageType, type, prescription, purchaseinfo) VALUES ('\(name)',\(dosage),'\(dosageType)','\(type)', \(prescription), '\(purchaseinfo)');"
            DButils.insert(db: db,insertStatementString: insertSettingsStatementString)
        } else {
            let updateSettingString = "UPDATE  SET instructionFlag = '\(instructionsFlag)', notificationsEnabled = '\(notifcationsEnabled)', showingPreviews = '\(showingPreviews)' WHERE user = '\(user)';"
            DButils.update(db:db, updateStatementString: updateSettingString)
        }
            //KAVYA TBD Use a for loop to get the rows for days and times and add it here
            // call add schedule row
        
    }
    static func checkIfFirstTime() -> Bool{
        var retVal = false
        let settings = getSettings()
        if(!settings.isEmpty) {
            let instructionsFlag = settings[1]
            if instructionsFlag == "true" {
                retVal = true
            }
        }
        return retVal
    }
    
    static func updateFirstTimeFlagSettings(instructionsFlag :String) {
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let updateSettingString = "UPDATE  SET instructionFlag = '\(instructionsFlag)';"
        DButils.update(db:db, updateStatementString: updateSettingString)
    }
    
    static func updateNotificationSettings(notificationsEnabled :String) {
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let updateSettingString = "UPDATE  SET notificationsEnabled = '\(notificationsEnabled)';"
        DButils.update(db:db, updateStatementString: updateSettingString)
        
        //Additional process to remove all notifications from all medicines if the current value is false
        //Kavya TBD
        //Otherwise update notifications for each medicine if current value is true
        //Kavya TBD
        
    }
    
    static func getSettings () -> [String] {
        var settings = [String]()
        let queryStatementString = "SELECT * FROM Settings;"
        //       let queryStatementString = "SELECT * FROM MedLog WHERE  date > date('now','-30 years');"
        //let queryStatementString = "SELECT * FROM MedLog ;"
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let settingsArray = querySettings(db:db,queryStatementString: queryStatementString)
        for row in settingsArray! {
            print(row)
        let m = row.components(separatedBy: ",")
            print(m)
            let user = m[0]
            print(user)
            let instructionsFlag = m[1]
            let notificationsEnabled = m[2]
            let showingPreviews = m[3]
            
            settings.append(user)
            settings.append(instructionsFlag)
            settings.append(notificationsEnabled)
            settings.append(showingPreviews)
            //let record = MedicineLog(name:nameVal,dayVal: dayVal,timeVal: timeVal,taken: takenVal, date : date)
        }
        //           var med = Medicine(name: "Hello",dosage:1,dosageType: 2,type: 4,prescription:true)
        // Call Query with right query
        
        //Create the Medicine Array and return it.
        
        // Create a for loop and in that for loop add medicines and return

        return settings
    }
    
    static func querySettings(db: OpaquePointer, queryStatementString: String) -> [String]? {
        var settingsArray = [String]()
        var setting = ""
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString,
                              -1,
                              &queryStatement,
                              nil
            ) == SQLITE_OK {
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                guard let queryResultCol0 = sqlite3_column_text(queryStatement, 0) else {
                    print("Query result is nil.")
                    return nil
                }
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else{
                    return nil
                }
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    return nil
                }
                guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                                   return nil
                               }
                let user = String(cString: queryResultCol0)
                let instructionsFlag = String(cString: queryResultCol1)
                let notificationsEnabled = String(cString: queryResultCol2)
                let showingPreviews = String(cString: queryResultCol3)

                setting.append(user + ",")
                setting.append(instructionsFlag + ",")
                setting.append(notificationsEnabled + ",")
                setting.append(showingPreviews + ",")
                print(setting)
                settingsArray.append(setting)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return settingsArray
    }
}

//
//  MedicineStruct.swift
//  turmeric
//
//  Created by kavya sriram on 9/19/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation


class MedicineSchedule : Identifiable {
    
    var days = [String]()
    var times = [String]()
    
    init() {
        days = []
        times = []
    }
    
    init(days:[String],times:[String]) {
        self.days = days
        self.times = times
    }
    
    //KAVYA TBD - Should take a row of MedicineSchedule table and add it to days and times if it is not already there.
    //used when retrieving from the database
    func addDaysTimesToSchedule(row: [String]){
        if days.contains(row[0]){
        } else{
            days.append(row[0])
        }
        if times.contains(row[1]){
        } else{
            times.append(row[1])
        }

    }


    
    //KAVYA TBD = to be used while adding This should return an array of string for each day and time
    //So, if a medicine needs to be had on M and Th for 2 times, it should return 4 rows.
    //called when taking the medicine from the screen and adding to the database
    func getScheduleRows() -> [(String,String)]{
        var rows = [(String,String)]()
        let daylist = days
        let timeslist = times
        for day in daylist{
            for time in timeslist{
                
                rows.append((day,time))
            }
        }
        print("to be done")
        return rows
    }
    
    func getDays() -> String {
        var str:String
        str = days.joined(separator: ", ")
        return str
    }
    
    func getDaysArr() -> [String] {
         return days
     }
    
    func getDaysAbbr() -> [String] {
        var abbrdays = [String]()
        for day in days{
            if day == "Mon"{
                abbrdays.append("M")
            }
            if day == "Tue"{
                abbrdays.append("T")
            }
            if day == "Wed"{
                abbrdays.append("W")
            }
            if day == "Thu"{
                abbrdays.append("Th")
            }
            if day == "Fri"{
                abbrdays.append("F")
            }
            if day == "Sat"{
                abbrdays.append("Sa")
            }
            if day == "Sun"{
                abbrdays.append("Su")
            }
            
        }
        
        return abbrdays
    }
    
    func getTimes() -> String {
        let listoftimes = times
        let str = String(describing:listoftimes)
        return str
        
    }
    
    func getScheduleFromDB(name: String) {
        //Get the rows for the medicne from schedule table
        var db : OpaquePointer
        db = DButils.openDatabase()!
        let selectStatement = "Select * from  MedSchedule where name = '\(name)'"
        DButils.query(db: db, queryString: selectStatement)
    }
    func getTimesList() -> MedicineTimesList {
        var timeslist = MedicineTimesList()
        for time in times{
            let mt = MedicineTime(tim: time)
            timeslist.addTimes(tim: mt)
        }
        return timeslist
    }
}

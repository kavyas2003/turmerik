//
//  TodayMedicineList.swift
//  turmeric
//
//  Created by sriram palapudi on 11/8/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import Foundation

class TodayMedicineList : ObservableObject {
    @Published var todayMedicineListItems = [MedicineNameTime]()
    
    init () {
    } //init
    
    func getMedicineList() -> [Medicine] {
        let medlist = MedicineHelper.getAllMedicine()
        var todaymedlist = [Medicine]()
        let currentDate = Date()
        for medicine in medlist{
            let startDateString = medicine.getStartDate()
            print(startDateString)
            let endDateString = medicine.getEndDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            dateFormatter.timeZone = .current
            //according to date format your date string
            var startDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            if (!startDateString.isEmpty) {
                startDate = dateFormatter.date(from: startDateString)!
            }
            var endDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            if(!endDateString.isEmpty) {
                endDate = dateFormatter.date(from: endDateString)!
            }
            let range = startDate...endDate
            print(" Dates: \(startDate) \(endDate) \(currentDate)")
            if range.contains(currentDate) {
                var weekDayString = ""
                let myCalendar = Calendar(identifier: .gregorian)
                let weekDay = myCalendar.component(.weekday, from: currentDate)
                if weekDay == 1{
                    weekDayString = "Sun"
                }
                if weekDay == 2{
                    weekDayString = "Mon"
                }
                if weekDay == 3{
                    weekDayString = "Tue"
                }
                if weekDay == 4{
                    weekDayString = "Wed"
                }
                if weekDay == 5{
                    weekDayString = "Thu"
                }
                if weekDay == 6{
                    weekDayString = "Fri"
                }
                if weekDay == 7{
                    weekDayString = "Sat"
                }
                let medicinedayslist = medicine.schedule.days
                if medicinedayslist.contains(weekDayString){
                    todaymedlist.append(medicine)
                }
            }
        }
        return todaymedlist
    }
    
    //    func getMedicineNameTime() -> [MedicineNameTime] {
    //        print("getMedicineName Inside")
    //        var sortedMedTimeList = [MedicineNameTime]()
    //        var isTaken = false
    //        let formatter = DateFormatter()
    //        formatter.locale = .current
    //        formatter.dateFormat = "MM/dd/yy"
    //        let date = formatter.string(from: Date())
    //        let medList = getMedicineList()
    //        for med in medList  {
    //            var times = med.schedule.times
    //            for time in times {
    //                let medicineLog = MedicineHelper.getMedicineLog(name: med.name, date: date, time: time)
    //                if(!(medicineLog.name == GlobalConstants.EMPTY) ) {
    //                    if medicineLog.taken == true{
    //                        isTaken = true
    //                    } else {
    //                        isTaken = false
    //                    }} else {
    //                    isTaken = false
    //                }
    //                let sortedNameTime = MedicineNameTime(name:med.name,timeStr:time,taken: isTaken,day:"",date: "")
    //                sortedMedTimeList.append(sortedNameTime)
    //            }
    //        }
    ////        print("Sorted List : \(sortedMedTimeList)")
    //        print("getMedicineNameOutside")
    //        return sortedMedTimeList
    //    }
    
    func load() {
        print("load Inside")
        var isTaken = false
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        let date = formatter.string(from: Date())
        todayMedicineListItems.removeAll()
        let medList = getMedicineList()
        for med in medList  {
            let times = med.schedule.times
            for time in times {
                let medicineLog = MedicineHelper.getMedicineLog(name: med.name, date: date, time: time)
                if(!(medicineLog.name == GlobalConstants.EMPTY) ) {
                    if medicineLog.taken == true{
                        isTaken = true
                    } else {
                        isTaken = false
                    }} else {
                    isTaken = false
                }
                let sortedNameTime = MedicineNameTime(name:med.name,timeStr:time,taken: isTaken,day:"",date: "")
                todayMedicineListItems.append(sortedNameTime)
            }
        }
        //        print("Sorted List : \(sortedMedTimeList)")
        print("load Outside")
    }
    
    func add( _ medicineNameTime :MedicineNameTime) {
        todayMedicineListItems.append(medicineNameTime)
    }
    
    func remove(_ medicineNameTime:MedicineNameTime) {
        if let index = todayMedicineListItems.firstIndex(of: medicineNameTime) {
            todayMedicineListItems.remove(at: index)
            todayMedicineListItems.append(medicineNameTime)
        }
    }
    
    func update(_ medicineNameTime:MedicineNameTime) {
        if let index = todayMedicineListItems.firstIndex(of: medicineNameTime) {
                   todayMedicineListItems.remove(at: index)
                   todayMedicineListItems.append(medicineNameTime)
               }
        //remove(medicineNameTime)
        //add(medicineNameTime)
    }
    
    func updateMedicine(_ medicine: Medicine) {
//        var i = 0
        for item in self.todayMedicineListItems {
            if item.name == medicine.getName() {
                remove(item)
            }
        }
        let currentDate = Date()
        var weekDayString = ""
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: currentDate)
        if weekDay == 1{
            weekDayString = "Sun"
        }
        if weekDay == 2{
            weekDayString = "Mon"
        }
        if weekDay == 3{
            weekDayString = "Tue"
        }
        if weekDay == 4{
            weekDayString = "Wed"
        }
        if weekDay == 5{
            weekDayString = "Thu"
        }
        if weekDay == 6{
            weekDayString = "Fri"
        }
        if weekDay == 7{
            weekDayString = "Sat"
        }
        let startDateString = medicine.getStartDate()
        print(startDateString)
        let endDateString = medicine.getEndDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        dateFormatter.timeZone = .current
        //according to date format your date string
        var startDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        if (!startDateString.isEmpty) {
            startDate = dateFormatter.date(from: startDateString)!
        }
        var endDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        if(!endDateString.isEmpty) {
            endDate = dateFormatter.date(from: endDateString)!
        }
        let schedule = medicine.schedule
        let rows = schedule.getScheduleRows()
        let range = startDate...endDate
        print(" Dates: \(startDate) \(endDate) \(currentDate)")
        if range.contains(currentDate) {
            for row in rows{
                let (dayVal, timeVal) = row
                let medicineNameTime = MedicineNameTime(name:medicine.getName(), timeStr:timeVal,taken:false,day:dayVal,date: "")
//                let medicinedayslist = medicine.schedule.days
//                if medicinedayslist.contains(weekDayString){
                if (dayVal == weekDayString) {
                    add(medicineNameTime)
                }
            }
        }
    }
    
    
    func addMedicine(_ medicine: Medicine) {
        let currentDate = Date()
        var weekDayString = ""
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: currentDate)
        if weekDay == 1{
            weekDayString = "Sun"
        }
        if weekDay == 2{
            weekDayString = "Mon"
        }
        if weekDay == 3{
            weekDayString = "Tue"
        }
        if weekDay == 4{
            weekDayString = "Wed"
        }
        if weekDay == 5{
            weekDayString = "Thu"
        }
        if weekDay == 6{
            weekDayString = "Fri"
        }
        if weekDay == 7{
            weekDayString = "Sat"
        }
        let startDateString = medicine.getStartDate()
        print(startDateString)
        let endDateString = medicine.getEndDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        dateFormatter.timeZone = .current
        //according to date format your date string
        var startDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        if (!startDateString.isEmpty) {
            startDate = dateFormatter.date(from: startDateString)!
        }
        var endDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        if(!endDateString.isEmpty) {
            endDate = dateFormatter.date(from: endDateString)!
        }
        let schedule = medicine.schedule
        let rows = schedule.getScheduleRows()
        let range = startDate...endDate
        print(" Dates: \(startDate) \(endDate) \(currentDate)")
        if range.contains(currentDate) {
            for row in rows{
                let (dayVal, timeVal) = row
                let medicineNameTime = MedicineNameTime(name:medicine.getName(), timeStr:timeVal,taken:false,day:dayVal,date: "")

//                let medicinedayslist = medicine.schedule.days
 //               if medicinedayslist.contains(weekDayString){
                if (dayVal == weekDayString) {
                    add(medicineNameTime)
                }
            }
        }
    }
    
    func printItem(_ str:String ) {
        for item in todayMedicineListItems {
            print("\(str) : \(item.name) \(item.taken) \(item.timeStr) \(item.day) \(item.date)")
        }
    }
    
} // TodayMedicineList

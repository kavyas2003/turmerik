//
//  MedicineHistoryView.swift
//  turmeric
//
//  Created by sriram palapudi on 11/21/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation

import SwiftUI

struct MedicineLogView: View {
    
    @State var name : String
    @Binding var previousView : Bool
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    
    @ObservedObject var notificationManager = LocalNotificationManager()
    @State var medicineNameTime = [MedicineNameTime]()
    @State var calData = CalendarData()
    @State var showMonth = false
    @State var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*60), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    //@State var todayMedicineList = MedicineList()
    @State var showFootnote = false
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        return NavigationView {
            VStack{
                // List (items.items) { item in
                Spacer().frame(height:10).onAppear(perform: {self.getMedicineLog(name:self.name)})
                //                HStack{
                //                                  Spacer().frame(width:10)
                //                                  Button(action: {
                //                                      self.list = self.updateList()
                //                                  }) {
                //                                      Image(systemName: "refresh")
                //                                      .resizable()
                //                                      .frame(width: 25, height: 20)
                //                                  }
                //                                  Spacer()
                //                              }
                List {
                    ForEach(medicineNameTime.sorted { $0.date > $1.date }, id:\.self) { (item) in
                        
                        /* NavigationLink(destination: MedicineDetailView(med:item,schedule:item.schedule,timeslist: item.schedule.getTimesList(), dayslist: ["",""]  )) {*/
                        HStack{
                            if(item.taken == true) {
                                Text(item.dateStr).foregroundColor(Color.green)
                                Text(item.day).foregroundColor(Color.green)
                                Text(item.timeStr).foregroundColor(Color.green)
                            } else {
                                Text(item.dateStr).foregroundColor(Color.red)
                                Text(item.day).foregroundColor(Color.red)
                                Text(item.timeStr).foregroundColor(Color.red)
                                
                            }
                            
                            /* TakenCheckboxField(
                             id: item.name,
                             label:"",
                             size: 16,
                             color: (self.colorScheme == .dark ? Color.white : Color.black),
                             textSize: 16,
                             callback: checkboxSelected, timeStr: item.timeStr,
                             isMarked: false //item.isMarked - need to add this to the medicinelist
                             )*/
                            //medname = item.name
                            // }
                            
                        }
                    }
                }
            }.navigationBarTitle("\(self.name) History", displayMode: .inline)
        }
    }
    //    func updateList() -> [MedicineNameTime] {
    //        return medicineNameTime.sorted { $0.date < $1.date }
    //    }
    
    func getMedicineLog(name:String) {
        let medicine = MedicineHelper.getMedicine(name: name)
        self.medicineNameTime = MedicineHelper.getMedicineLogs(med: medicine)
        self.medicineNameTime = medicineNameTime.sorted { $0.date < $1.date }
        let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "MM/dd/yy"
        var dateComponent = DateComponents()
        dateComponent.day = 1
        var currentDate = Date()
        if !medicineNameTime.isEmpty {
            currentDate = medicineNameTime[0].date
        }
        while currentDate <= Date() {
            var currentDateList = [MedicineNameTime]()
            for item in medicineNameTime {
                if item.date == currentDate {
                    currentDateList.append(item)
                }
            }
            var currentDateTimesList = [String]()
                  for item in currentDateList {
                      currentDateTimesList.append(item.timeStr)
                  }
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
            let currentDateStr = dateFormatter.string(from: currentDate)
            if currentDateList.count == 0{
                print(medicine.schedule.days)
                if medicine.schedule.days.contains(weekDayString) == true {
                    for time in medicine.schedule.times {
                        let medNameTime = MedicineNameTime(name: medicine.name, timeStr: time, taken: false, day: weekDayString, date: currentDateStr)
                        medicineNameTime.append(medNameTime)
                    }
                }
            }
            else if currentDateList.count != medicine.schedule.times.count {
                if medicine.schedule.days.contains(weekDayString) == true {
                for time in medicine.schedule.times {
                    if currentDateTimesList.contains(time) == false {
                        let medNameTime = MedicineNameTime(name: medicine.name, timeStr: time, taken: false, day: weekDayString, date: currentDateStr)
                        medicineNameTime.append(medNameTime)
                    }
                }
            }
            }

            currentDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
        }
        
        
        
        
        
        
        //        var medicineTimesList = [String]()
        //        let todayDate = Date()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        //        dateFormatter.dateFormat = "MM/dd/yy"
        //        var weekDayString = ""
        //                      let myCalendar = Calendar(identifier: .gregorian)
        //                      let weekDay = myCalendar.component(.weekday, from: todayDate)
        //                      if weekDay == 1{
        //                          weekDayString = "Sun"
        //                      }
        //                      if weekDay == 2{
        //                          weekDayString = "Mon"
        //                      }
        //                      if weekDay == 3{
        //                          weekDayString = "Tue"
        //                      }
        //                      if weekDay == 4{
        //                          weekDayString = "Wed"
        //                      }
        //                      if weekDay == 5{
        //                          weekDayString = "Thu"
        //                      }
        //                      if weekDay == 6{
        //                          weekDayString = "Fri"
        //                      }
        //                      if weekDay == 7{
        //                          weekDayString = "Sat"
        //                      }
        //
        //        var currDate = Date()
        //        var prevDate = Date()
        //        var firstFlag = true
        //        print(medicineNameTime)
        //        for medNameTime in medicineNameTime {
        //            if firstFlag {
        //                currDate = medNameTime.date
        //                prevDate = medNameTime.date
        //                firstFlag = false
        //            } else {
        //                currDate = medNameTime.date
        //            }
        //            if(currDate == prevDate) {
        //                    medicineTimesList.append(medNameTime.timeStr)
        //            } else {
        //                for nameTime in todayMedicineList.todayMedicineListItems {
        //                    if nameTime.name == name{
        //                        if medicineTimesList.contains(nameTime.timeStr) == false {
        //                        let dateString = dateFormatter.string(from: todayDate)
        //
        //                        let medNameTime = MedicineNameTime(name: nameTime.name, timeStr: nameTime.timeStr, taken: false, day: weekDayString, date: dateString)
        //                        medicineNameTime.append(medNameTime)
        //                        }
        //                    }
        //                }
        //                prevDate = medNameTime.date
        //                medicineTimesList.removeAll()
        //            }
        //        }
        //        for nameTime in todayMedicineList.todayMedicineListItems {
        //            if nameTime.name == name{
        //                if medicineTimesList.contains(nameTime.timeStr) == false {
        //                let dateString = dateFormatter.string(from: todayDate)
        //
        //                let medNameTime = MedicineNameTime(name: nameTime.name, timeStr: nameTime.timeStr, taken: false, day: weekDayString, date: dateString)
        //                medicineNameTime.append(medNameTime)
        //                }
        //            }
        //        }
        
        
    }
}

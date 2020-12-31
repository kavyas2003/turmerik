//
//  LocalNotificationManager.swift
//  NotificationExample
//
//  Created by sriram palapudi on 9/18/20.
//  Copyright © 2020 Kavya Sriram. All rights reserved.
//

import Foundation
import SwiftUI

class LocalNotificationManager: ObservableObject {
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    //    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Double) {
    //
    //        let content = UNMutableNotificationContent()
    //        content.title = title
    //        if let subtitle = subtitle {
    //            content.subtitle = subtitle
    //        }
    //        content.body = body
    //
    //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
    //        let request = UNNotificationRequest(identifier: "demoNotification", content: content, trigger: trigger)
    //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    //
    //
    //
    //
    //    }
    
    func addNotification(name: String, dayVal: String, timeVal: String, deferFlag : Bool ) {
        // Define the custom actions.
        //Split it into elements
        let content = UNMutableNotificationContent()
        //        let name = medicine.getName()
        //let dosage = medicine.getDosage()
        //let dosageType = medicine.getDosageType()
        content.title = "Medicine Reminder "
        content.body = "Please take \(name) Now at \(timeVal) "
        content.userInfo = ["name": name, "dayVal": dayVal, "timeVal": timeVal]
        content.categoryIdentifier = "Medicine Reminder"
        var dayNum = 0
        if dayVal == "Mon"{
            dayNum = 2
        }
        if dayVal == "Tue"{
            dayNum = 3
        }
        if dayVal == "Wed"{
            dayNum = 4
        }
        if dayVal == "Thu"{
            dayNum = 5
        }
        if dayVal == "Fri"{
            dayNum = 6
        }
        if dayVal == "Sat"{
            dayNum = 7
        }
        if dayVal == "Sun"{
            dayNum = 1
        }
        let timelist = timeVal.split(separator: ":")
        print(timelist)
        if (!timelist.isEmpty) {
            let hour = timelist[0]
            let minute = timelist[1]
            let trigger:UNCalendarNotificationTrigger
            
            //Get AM or PM as well.
            let ampmlist = timeVal.split(separator: " ")
            var i = Int(hour) ?? 0
            if(ampmlist[1] == "PM") {
                i = i  + 12
            }
            var dateComponents = DateComponents()

            dateComponents.minute = Int(minute)
            dateComponents.weekday = dayNum
            print("1 dateCompoents \(dateComponents)")
            if(deferFlag == true) {
                print("i : \(i) hour \(hour) ")
                let j = 1
                let k = i + j
                dateComponents.hour = k
                print("12 dateCompoents \(dateComponents)")
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            } else {
                dateComponents.hour = i
                print("13 dateCompoents \(dateComponents)")
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            }
            var id = name + "_" + dayVal + "_"
            id = id + hour + "_"
            id = id + minute + "_" + ampmlist[1]
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request, withCompletionHandler: nil)
        }
        
    }
    
    func addNotificationRange(name: String, dayVal: String, timeVal: String , startDate : String, endDate : String) {
        // Define the custom actions.
        //Split it into elements
        let content = UNMutableNotificationContent()
        //        let name = medicine.getName()
        //let dosage = medicine.getDosage()
        //let dosageType = medicine.getDosageType()
        content.title = "Medicine Reminder "
        content.body = "Please take \(name) Now"
        content.userInfo = ["name": name, "dayVal": dayVal, "timeVal": timeVal]
        content.categoryIdentifier = "Medicine Reminder"
        var dayNum = 0
        if dayVal == "Mon"{
            dayNum = 2
        }
        if dayVal == "Tue"{
            dayNum = 3
        }
        if dayVal == "Wed"{
            dayNum = 4
        }
        if dayVal == "Thu"{
            dayNum = 5
        }
        if dayVal == "Fri"{
            dayNum = 6
        }
        if dayVal == "Sat"{
            dayNum = 7
        }
        if dayVal == "Sun"{
            dayNum = 1
        }
        let timelist = timeVal.split(separator: ":")
        print(timelist)
        if (!timelist.isEmpty) {
            let hour = timelist[0]
            let minute = timelist[1]
            
            //Get AM or PM as well.
            let ampmlist = timeVal.split(separator: " ")
            var i = Int(hour)
            if(ampmlist[1] == "PM") {
                i = i! + 12
            }
            
            //For loop for the range  from start date to end date.
            
            var dateComponents = DateComponents()
            dateComponents.hour = i
            dateComponents.minute = Int(minute)
            dateComponents.weekday = dayNum
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            var id = name + "_" + dayVal + "_"
            id = id + hour + "_"
            id = id + minute + "_" + ampmlist[1]
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request, withCompletionHandler: nil)
        }
        
    }
    func removeNotifications(ids: [String]) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
}

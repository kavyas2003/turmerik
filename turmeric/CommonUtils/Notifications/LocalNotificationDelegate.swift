//
//  LocalNotificationDelegate.swift
//  NotificationExample
//
//  Created by sriram palapudi on 9/18/20.
//  Copyright © 2020 Kavya Sriram. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificatonDelegate: NSObject,UNUserNotificationCenterDelegate {
    
    static var todayMedicineList = TodayMedicineList()
    
    func setCategoriesActions() {
        let acceptAction = UNNotificationAction(identifier: "YES_ACTION",
                                                title: "Yes",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let declineAction = UNNotificationAction(identifier: "NO_ACTION",
                                                 title: "No",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        let deferAction = UNNotificationAction(identifier: "DEFER_ACTION",
                                               title: "Defer 1 Hr",
                                               options: UNNotificationActionOptions(rawValue: 0))
        // Define the notification type
        let medicineReminderCategory =
            UNNotificationCategory(identifier: "Medicine Reminder",
                                   actions: [acceptAction, declineAction, deferAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
        // Register the notification type.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([medicineReminderCategory])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler:
        @escaping () -> Void) {
        
        // Get the meeting ID from the original notification.
        let userInfo = response.notification.request.content.userInfo
 //       print("USERINFO: \(userInfo)")
 //       print("Name \(userInfo["name"])")
        // Perform the task associated with the action.
        switch response.actionIdentifier {
        case "YES_ACTION":
            print("accepted")
            MedicineHelper.addMedicineLog(medicine: userInfo["name"] as! String, day: userInfo["dayVal"] as! String, time: userInfo["timeVal"] as! String,taken: true)
            LocalNotificatonDelegate.todayMedicineList.load()
            break
            
        case "NO_ACTION":
            print("declined")
            MedicineHelper.addMedicineLog(medicine: userInfo["name"] as! String, day: userInfo["dayVal"] as! String, time: userInfo["timeVal"] as! String,taken: false)
            LocalNotificatonDelegate.todayMedicineList.load()
            break
        
        case "DEFER_ACTION":
            print("deferred")
            deferEvent(name: userInfo["name"] as! String, day: userInfo["dayVal"] as! String, time: userInfo["timeVal"] as! String)
            
        default:
//            MedicineHelper.addMedicineLog(medicine: userInfo["name"] as! String, day: userInfo["dayVal"] as! String, time: userInfo["timeVal"] as! String,taken: true)
            break

        }
        
        // Always call the completion handler when done.
        completionHandler()
    }
    
    func deferEvent(name:String,day:String,time:String) {
        let lm = LocalNotificationManager()
//        print("time = \(time)")
//        let timelist = time.split(separator: ":")
//        let timeVal = ""
//        print(timelist)
//        if (!timelist.isEmpty) {
//            var hour = timelist[0]
//            let minute = timelist[1]
//            let second = timelist[2]
//
//            //Get AM or PM as well.
//            var ampmlist = time.split(separator: " ")
//            if  hour == "12" {
//                if(ampmlist[1] == "PM") {
//                    ampmlist[1] = "AM"
//                } else {
//                    ampmlist[1] = "PM"
//                }
//                hour = "1"
//            } else {
//                let i = Int(hour)
//                hour = "\(String(describing: i))"
//            }
//            timeVal = "\(hour):\(minute):\(second) \(ampmlist[1])"
//        }
        lm.addNotification(name: name, dayVal: day, timeVal: time, deferFlag: true)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Get the meeting ID from the original notification.
        let request = notification.request
        let content = request.content
        print(content.title)
        print(content.categoryIdentifier)
            // Handle other actions…

        
        // Always call the completion handler when done.
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
}

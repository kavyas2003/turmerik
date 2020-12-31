

    //
    //  LocalNotificationManager.swift
    //  turmeric
    //
    //  Created by kavya sriram on 7/29/20.
    //  Copyright © 2020 kavya sriram. All rights reserved.
    //

   /* import Foundation
    import UserNotifications

    struct Notification {
        var id: String
        var title: String
    }

   class LocalNotificationManager {
        var notifications = [Notification]()
        
        func requestPermission() -> Void {
            UNUserNotificationCenter
                .current()
                .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                    if granted == true && error == nil {
                        // We have permission!
                    }
            }
        }
        func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
            func setNotification() -> Void {
                let manager = LocalNotificationManager()
                manager.requestPermission()
                manager.addNotification(title: "This is a test reminder");)
                manager.scheduleNotification()
            }
    }
    } */



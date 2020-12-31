//
//  MedicineNameTime.swift
//  turmeric
//
//  Created by kavya sriram on 11/18/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
struct MedicineNameTime : Hashable{
    
    var name:String
    var timeStr:String
    var timeDate:Date //This is the time that is used for the time of the day the medicine is to be had
    var taken:Bool
    var day:String
    var date:Date  // This is the time used by the history or logs
    var dateStr:String //To be used for display in the logview
    
    init(name:String, timeStr:String,taken:Bool,day:String,date: String) {
        self.name = name
        self.timeStr = timeStr
        self.taken = taken
        self.day = day
        let df = DateFormatter()
        df.timeStyle = .medium
        self.timeDate = df.date(from: self.timeStr)!
        if(!date.isEmpty) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "MM/dd/yy"
            self.date = dateFormatter.date(from:date)!
        } else {
            self.date = Date()
        }
        dateStr = date
    }
    
    init () {
        self.name  = GlobalConstants.EMPTY
        self.timeStr = GlobalConstants.EMPTY
        self.taken = true
        self.day = GlobalConstants.EMPTY
        self.date = Date()
        self.dateStr =  GlobalConstants.EMPTY
        self.timeDate = Date()
    }
    static func == (lhs: MedicineNameTime, rhs: MedicineNameTime) -> Bool {
        var boolVal = Bool()
        if((lhs.timeDate == rhs.timeDate) && (lhs.name == rhs.name) && (lhs.date == rhs.date)){
            boolVal = true
        }
        return boolVal
    }
    
    static func getMedicine(name: String) -> Medicine {
        return MedicineHelper.getMedicine(name: name)
    }
    
}

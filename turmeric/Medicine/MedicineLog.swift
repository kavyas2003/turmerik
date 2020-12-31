//
//  Records.swift
//  turmeric
//
//  Created by kavya sriram on 10/3/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
class MedicineLog: Identifiable {
    var name = ""
  var dayVal = ""
  var timeVal = ""
  var taken = ""
    var date = ""
  
  init() {
    name = ""
    dayVal = ""
    timeVal = ""
    taken = ""
    date = ""
  }
  
    init(name: String, dayVal: String, timeVal: String, taken: String, date : String) {
        self.name = name
        self.dayVal = dayVal
        self.timeVal = timeVal
        self.taken = taken
        self.date = date
  }
}

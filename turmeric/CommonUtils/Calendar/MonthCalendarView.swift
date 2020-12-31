

//
//  MonthCalendarView.swift
//  turmeric
//
//  Created by kavya sriram on 6/25/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct MonthCalendarView: View {
    @State var showingDayCalendar = false
    @State var showingHome = false

    var body: some View {
        VStack{
        Text("Month")
        Button(action: {
              self.showingDayCalendar.toggle()
                    } ) {
                Text("Complete")
            }.sheet(isPresented: $showingDayCalendar) {
                DayCalendarView()
            }
            Button(action: {
                         self.showingHome.toggle()
                               } ) {
                           Text("View Medication List")
                       }.sheet(isPresented: $showingHome) {
                           MedicineListView()
                       }
                
        }
    }
}


struct MonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}


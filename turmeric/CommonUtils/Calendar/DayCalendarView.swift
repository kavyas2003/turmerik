

//
//  DayCalendarView.swift
//  turmeric
//
//  Created by kavya sriram on 6/25/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct DayCalendarView: View {
    @State var showingHome = false
    @State var showingMonthCalendar = false
    
    var body: some View {
        
        VStack{
            Text("Date")
            Spacer()
            Button(action: {
                self.showingHome.toggle()
            } ) {
                Text("View Medication List")
            }.sheet(isPresented: $showingHome) {
                MedicineListView()
            }
            Spacer()
            Button(action: {
                self.showingMonthCalendar.toggle()
            } ) {
                Text("View Month Calendar")
            }.sheet(isPresented: $showingMonthCalendar) {
                MonthCalendarView()
            }
        }
    }
}

struct DayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        DayCalendarView()
    }
}


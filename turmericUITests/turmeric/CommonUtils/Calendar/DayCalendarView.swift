

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
    @State var showingSettings = false
    
    var body: some View {
        
        VStack{
          Text("Date")
            Spacer()
            Button(action: {
                  self.showingHome.toggle()
                        } ) {
                    Text("View Medication List")
                }.sheet(isPresented: $showingHome) {
                    HomeView()
            }
            Spacer()
            Button(action: {
                  self.showingMonthCalendar.toggle()
                        } ) {
                    Text("View Month Calendar")
                }.sheet(isPresented: $showingMonthCalendar) {
                    MonthCalendarView()
            }
            Button(action: {
                    self.showingMonthCalendar.toggle()
                    } ) {
                               Text("Settings")
                           }.sheet(isPresented: $showingSettings) {
                              SettingsView()
                       }
                    
        }
    }
}

struct DayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        DayCalendarView()
    }
}


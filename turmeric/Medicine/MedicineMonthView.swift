//
//  ContentView.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//


import SwiftUI

struct MedicineMonthView : View {
    
    @Binding var parentView : Bool
    @Binding var rkManager : RKManager
    
    @State var singleIsPresented = false
    @State var startIsPresented = false
    @State var multipleIsPresented = false
    @State var deselectedIsPresented = false
    
    //Single Select View that returns the Date selected.
    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*60), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
 
    //rkManager = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*60), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
    var rkManager2 = RKManager(calendar: Calendar.current, minimumDate: Date() , maximumDate: Date().addingTimeInterval(60*60*24*7), mode: 1) // automatically goes to mode=2 after start selection, and vice versa.
    
    var rkManager3 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 3)
    
    var rkManager4 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
    
    var body: some View {
        VStack (spacing: 25) {
            
  //          RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)
            RKViewController(isPresented: self.$parentView, rkManager: self.rkManager)
            datesView(dates: self.rkManager3.selectedDates)
            datesView(dates: self.rkManager4.disabledDates)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func datesView(dates: [Date]) -> some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(dates, id: \.self) { date in
                    Text(self.getTextFromDate(date: date) + "5")
                }
            }
        }.padding(.horizontal, 15)
    }
 
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }

}

#if DEBUG
struct MedicineCalendarView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

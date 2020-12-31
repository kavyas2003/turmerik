//
//  AppView.swift
//  turmeric
//
//  Created by sriram palapudi on 9/13/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct TabbedAppView: View {
    @EnvironmentObject var items: MedicineList
    @EnvironmentObject var todayMedicineList: TodayMedicineList
   // @EnvironmentObject var medicineLogList: MedicineLogList
    var body: some View {
        TabView {
            MedicineDayView().environmentObject(items).environmentObject(todayMedicineList)//.environmentObject(medicineLogList)
            //                RKContentView()
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("Today")
           
            }.tag(0)
            MedicineListView().environmentObject(items).environmentObject(todayMedicineList)//.environmentObject(medicineLogList)
                           .tabItem {
                               
                               Image(systemName: "list.dash")
                               Text("Medicines")
            }.tag(1)
            SettingsView().environmentObject(items).environmentObject(todayMedicineList)//.environmentObject(medicineLogList)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Settings")
            }.tag(2)
            MedicineHelpView()
                .tabItem {
                    Image(systemName : "questionmark.circle")
                    Text("Help")
            }.tag(3)
        }
    }
}

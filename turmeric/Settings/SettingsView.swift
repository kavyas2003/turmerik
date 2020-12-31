//
//  SettingsView.swift
//  testproject1000
//
//  Created by kavya sriram on 6/20/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var items: MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList

    @State var username: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = true
    @State private var previewIndex = 0
    @State var showingHome = false
    var previewOptions = ["Always", "When Unlocked", "Never"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ABOUT TURMERIK")) {
                    
                    Text("Turmerik is an application that stores a user's medication schedule and consumptoin histroy. Additionally, users can revisit when they have taken, and when they have missed their medications. It also provides services such as reminding you when a medicine's count is approaching zero, where and when it was purchased, and when it expires. Features will be added as new versions of the app are uploaded. ")
                    
                    
                }
                //Section(header: Text("PROFILE")) {
                //  TextField("Username", text: $username)
                //                    Toggle(isOn: $isPrivate) {
                //                        Text("Private Account")
                //                    }
                // }
      
                //Currently disabled till the full functionality is implemented.
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enabled")
                    //}.onTapGesture{
                         .onReceive([self.notificationsEnabled].publisher.first()) { (value) in
                        if self.notificationsEnabled == false {
                            self.deleteNotifications()
                        }
                        if self.notificationsEnabled == true {
                            self.addNotifications()
                        }
                    }
                }
            }
//
//                    Picker(selection: $previewIndex, label: Text("Show Previews")) {
//                        ForEach(0 ..< previewOptions.count) {
//                            Text(self.previewOptions[$0])
//                        }
//                    }.onTapGesture{
//                        MedicineHelper.addSettings(instructionsFlag: "false", notifcationsEnabled: String(self.notificationsEnabled), showingPreviews: self.previewOptions[self.previewIndex], add: false)
//                    }
//                }
                
                Section(header: Text("ABOUT")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("3.4")
                    }
                }
//                Section(header: Text("Help")) {
//                    Text("To add a medicine, select the middle \n tab called 'Medicines' and click the plus button. Fill out the information and pick the schedule  for that medicine. Press add and your medicines will show up in the middle tab.The tab called 'Today' will display all the medicines you have scheduled for that day and what time to take them. Select the checkbox once it is taken.To view the history of a medication  either select one of the times in the 'Today' tab or go to its detail page and click on the button 'Medicine Logs. To edit any details for a medicine or its schedule, select Edit on the detail page. To reset the app, go to 'Settings' \nand select the reset option.")
//                }
                
                Section {
                    Button(action: {
                        for item in self.items.items {
                            MedicineHelper.removeMedicine(name: item.name)
                        }
                        MedicineHelper.resetMedicineTable()
                        UserHelper.deleteUser(username: self.username)
                        self.items.items.removeAll()
                        self.todayMedicineList.todayMedicineListItems.removeAll()
                        //                        self.showingLogin.toggle()
                        
                        
                    } ) {
                        Text("Reset ALL Settings")
                        //                  }
                    }.sheet(isPresented: $showingHome) {
                        MedicineListView().environmentObject(self.items)
                    }
                    
                    /* Button(action: {
                     self.showingLogin1.toggle()
                     self.items.items.removeAll()
                     
                     } ) {
                     Text("Logout")
                     }.sheet(isPresented: $showingLogin1) {
                     LoginView().environmentObject(self.items)
                     } */
                }
                .navigationBarTitle("Settings")
            }
            
        }
        
        
    }
       func loadSettings() -> Void{
        let setting = MedicineHelper.getSettings()
        if setting[2] == "true"{
            notificationsEnabled = true
        } else {
            notificationsEnabled = false
        }
        if setting[3] == "Always"{
            previewIndex = 0
        } else if setting[3] == "When Unlocked" {
            previewIndex = 1
        } else {
            previewIndex = 2
        }
    }
    
    func addNotifications() {
        //ForEach(items.items.sorted { $0.name < $1.name }, id:\.self) { (item) in
        for item in items.items{
            MedicineHelper.addMedicineNotifications(name: item.name)
        }
    }
    func deleteNotifications() {
        for item in items.items {
        MedicineHelper.removeMedicineNotifications(name: item.name)
    }
        }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

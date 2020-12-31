//
//  MedicineHelp.swift
//  turmeric
//
//  Created by sriram palapudi on 12/6/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
import SwiftUI

struct MedicineHelpView: View {
    @EnvironmentObject var items:MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    
    var body: some View {
        VStack{
            Form {
            Section(header: Text("Adding a Medicine")) {
                Text("Select the 'Medicine' tab and use the + button to add Medicine. Add the details and use the schedule to add the schedule. Notifications will show up based on the schedule")
            }
            Section(header: Text("Notifications ")) {
                    Text("Use 'Long Press' or 'Swipe Left' on the notificatins to view the options \n You can also use the Edit button to indicate that the medicine was consumed.")
            }
            Section(header: Text("Removing a Medicine")) {
                Text("Swipe to the right on the medicine you want to remove ")
            }
            Section(header: Text("Viewing a Medicine's History")) {
                Text("In the 'Today' tab click on a medicine detail to see the history of that medicine")
            }
            Section(header: Text("Resetting Your Account")) {
                Text("Go to 'Settings' and select 'Reset All Settings'.")
                }
            }
        }
    }
}

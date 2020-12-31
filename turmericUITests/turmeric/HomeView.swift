//
//  HomeView.swift
//  dawana
//
//  Created by kavya sriram on 4/21/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import SwiftUI

let medicines = "SELECT * FROM Medicine;"

struct HomeView: View {
    
     @State var showingDetail = false
     @State var showingAdd = false
     @State var textToUpdate = ""
    @State var deletemed = ""
    
    var body: some View {
       
        
        HStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    
                    Button(action: {
                        self.showingAdd.toggle()
                        }) {
                            Text("Add Medicine")
                        }.sheet(isPresented: self.$showingAdd) {
                                    AddMedicineView()
                                }
                    Button(action: {
                       
                        var meds = MedicineHelper.getallmedicine()
                        print("meds:\(meds)")
                        var mednamelist = [String]()
                        for med in meds{
                            let x = med.getName()
                            mednamelist.append(x)
                            self.textToUpdate = String(describing: mednamelist)
                        }
                        }) {
                            Text("Display Medicine")
                        }
                         
                        Text(textToUpdate)
                        
                    
                    
                    Button(action: {
                        MedicineHelper.removeMedicine(name: self.deletemed)
                        }) {
                            Text("Delete Medicine")
                        }
                    TextField("Medicine Name", text: self.$deletemed)

                    
                    Button("Send Notification") {
                           // 1.
                           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
                                 success, error in
                                     if success {
                                         print("authorization granted")
                                     } else if let error = error {
                                         
                                     
                             }
                             // 2.
                             let content = UNMutableNotificationContent()
                                 content.title = "Notification Tutorial"
                                 content.subtitle = "from ioscreator.com"
                                 content.body = " Notification triggered"
                                 content.sound = UNNotificationSound.default
                                    
                             // 3.
                             //let imageName = "applelogo"
                            
                            // guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else {
                                
                                // let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
                             
                            // content.attachments = [attachment]
                                    
                             // 4.
                            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                            //let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
                         
                            // 5.
                           // UNUserNotificationCenter.current().add(request)
                       //  }
                    
                      //  }
                    }
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

}

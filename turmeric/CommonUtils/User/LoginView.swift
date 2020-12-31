
//
//  LoginView.swift
//  dawana
//
//  Created by kavya sriram on 4/21/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import SwiftUI
import SQLite3


struct LoginView : View {
    
    @EnvironmentObject var items: MedicineList
    
    @State var username: String = ""
    @State private var password: String = ""
    @State var showingDayCalendar = false
    @State var showingRegister = false
    @State var showingCalendar = false
    @State var user = ""
    @State var querypassword = ""
    @State var queryusername = ""
    @State var text = ""
    
    var body: some View  {
        NavigationView {
            
            VStack (alignment: .center, spacing : 10) {
                
                //Username
                TextField("Please enter username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //Password
                SecureField("Please enter password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                //Login Button
                Button(action: {
                    let user = UserHelper.getUser(username: self.username)
                    print(user)
                    self.queryusername = user.getUsername()
                    print("queryusername:\(self.queryusername)")
                    self.querypassword = user.getPassword()
                    print("querypassword:\(self.querypassword)")
                    if self.queryusername == self.username && self.querypassword == self.password{
                        self.showingDayCalendar.toggle()
                        //Load up the items object so that it is available to all the views
                        let medicineList = MedicineHelper.getAllMedicine()
                        if medicineList.count == 0  && self.items.items.count == 0 {
                            let med = Medicine(name: GlobalConstants.USENEW, dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: GlobalConstants.EMPTY, schedule:MedicineSchedule(), startdate: "", enddate: "", totalcount: 1, expirydate: "", ingredientsUrl: "")
                            self.items.addMedicine(med: med)
                        }
                        for item in medicineList {
                            self.items.addMedicine(med: item)
                        }
                    } else {
                        self.text = ErrorMessage.INVALIDUSERNAMEPASSWORD
                    }
                }) {
                    Text("Login").sheet(isPresented: $showingDayCalendar) {
                        TabbedAppView().environmentObject(self.items)
                    }
                }
                
                //Register Button
                Button(action: {
                    self.showingRegister.toggle()
                    
                } ) {
                    Text("Register")
                }.sheet(isPresented: $showingRegister) {
                    RegisterView().environmentObject(self.items)
                }
                
            }
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    
    
}

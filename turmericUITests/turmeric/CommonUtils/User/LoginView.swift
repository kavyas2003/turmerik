
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
    
    @State private var username: String = ""
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
                        //DayCalendarView()
                        } else {
                        self.text = "Invalid username or password"
                        }
                }) {
                    Text("Login").sheet(isPresented: $showingDayCalendar) {
                        DayCalendarView()
                       // Text(self.text)
                    }
                }
                    
                //Register Button
                Button(action: {
                      self.showingRegister.toggle()
                               
                        } ) {
                        Text("Register")
                        }.sheet(isPresented: $showingRegister) {
                        RegisterView()
                }
               
            }
        }
    }

    
    struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
    }


}



//
//  RegisterView.swift
//  turmeric
//
//  Created by kavya sriram on 6/25/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State var showingDayCalendar = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var name: String = ""


    
    var body: some View {
        
        VStack{
            Text("Register")
            
        TextField("Please enter username", text: $username, onEditingChanged: { (changed) in
            print("Username onEditingChanged - \(changed)")
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
        SecureField("Please enter password", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("Please enter email", text: $email, onEditingChanged: { (changed) in
            print("email onEditingChanged - \(changed)")
            })
            TextField("Please enter name", text: $name, onEditingChanged: { (changed) in
            print("name onEditingChanged - \(changed)")
            })
            
            Spacer()
            Button(action: {
                self.showingDayCalendar.toggle()
                var db : OpaquePointer
                db = DButils.openDatabase()!
                           
                               let dropTableString = """
                               drop table User;
                               """
                           
                DButils.dropTable(db:db, dropTableString : dropTableString)
                           
                               let createTableString = """
                               CREATE TABLE User(
                               name CHAR(255),
                               username CHAR(255),
                               password CHAR(255),
                               email CHAR(255));
                               """

                DButils.createTable(db: db, createTableString: createTableString)
                
                UserHelper.UserInsert(name: self.name as NSString, username: self.username as NSString, password: self.password as NSString, email: self.email as NSString)
                        } ) {
                    Text("Complete")
                }.sheet(isPresented: $showingDayCalendar) {
                    DayCalendarView()
                    
            }

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}


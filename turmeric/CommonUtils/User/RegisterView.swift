

//
//  RegisterView.swift
//  turmeric
//
//  Created by kavya sriram on 6/25/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State var showingtabs = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var name: String = ""

    @EnvironmentObject var items: MedicineList
    
    var body: some View {
        VStack{
            Text("Register")
            HStack{
              Text("Username")
                TextField("Please enter username", text: $username, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
               Text("Password")
                SecureField("Please enter password", text: $password)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        
            HStack{
                Text("Email")
                TextField("Please enter email", text: $email, onEditingChanged: { (changed) in
                           print("email onEditingChanged - \(changed)")
                           })
                           .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                
            HStack{
                Text("Name")
                TextField("Please enter name", text: $name, onEditingChanged: { (changed) in
                print("name onEditingChanged - \(changed)")
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
               
                Button(action: {
                    self.showingtabs.toggle()
                    
                    
                    UserHelper.createUserDB()
                    MedicineHelper.createTurmericDB()
                    UserHelper.UserInsert(name: self.name as NSString, username: self.username as NSString, password: self.password as NSString, email: self.email as NSString)

                            } ) {
                        Text("Complete")
                    }.sheet(isPresented: $showingtabs) {
                        TabbedAppView().environmentObject(self.items)
                        
                }

                
                
                
            
            
        
            
        
            
            
        }

        }
    }


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}


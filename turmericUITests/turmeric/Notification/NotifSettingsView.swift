

//
//  NotifSettingsView.swift
//  turmeric
//
//  Created by kavya sriram on 6/25/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct NotifSettingsView: View {
    @State var showingSettings = false
    var body: some View {
        VStack{
            Text("Notifications")
        Button(action: {
          self.showingSettings.toggle()
                } ) {
            Text("Back")
        }.sheet(isPresented: $showingSettings) {
            SettingsView()
            }
        }
    }
}

struct NotifSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotifSettingsView()
    }
}



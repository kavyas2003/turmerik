


//
//  MedicineDetail.swift
//  testproject1000
//
//  Created by kavya sriram on 6/14/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI


struct MedicineDetail: View {
    @State var showingHome = false
    
    var body: some View {
        VStack{
            Button(action: {
                    self.showingHome.toggle()
                }) {
                    Text("Back")
            }.sheet(isPresented: self.$showingHome) {
                    HomeView()
            }
            Spacer()
            
            MedicineImage()
                     .offset(y: -130)
                     .padding(.bottom, -130)
                     
                     VStack(alignment: .leading) {
                         Text("Albuterol")
                             .font(.title)
                     }
                         
                     .padding()
                     
                     Spacer()
        }
    }
}

struct MedicineDetail_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetail()
    }
}




//
//  TestList.swift
//  turmeric
//
//  Created by sriram palapudi on 9/14/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import SwiftUI


struct MedicineListView: View {
    
    @EnvironmentObject var items: MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    @State private var navBarHidden = true
    @State var medname = ""
    @State var med = Medicine()
    @State var instructionsFlag = true
    
    var body: some View {
        //        List(items) { row in
        //  //          Image( uiImage: row.getPicture())
        //            Text(row.name)
        //        }
        
        return NavigationView {
            VStack{
                //MedicineDetailView(med: med, schedule: med.schedule)
                Spacer().frame(height:20).onAppear(perform: {self.items.load()})
                NavigationLink(destination: AddMedicineView()) {
                    HStack(alignment: .bottom){
                        Spacer()
                        //.frame(width: 10)
                        Image(systemName: "plus")
                        Spacer().frame(width: 10)
                        
                    }
                }
                //List (items.items) { item in
                List {
                    ForEach(items.items.sorted { $0.name < $1.name }) {(item) in
                        NavigationLink(destination: MedicineDetailView(med:item,schedule:item.schedule,timeslist: item.schedule.getTimesList(), daysList: item.schedule.days, timesList: item.schedule.times )) {
                            HStack{
                                Image(uiImage: item.getMedicineImage())
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 4)
                                
                                Text(item.name)
                                //medname = item.name
                                
                            }
                        }
                    }.onDelete(perform: self.deleteItem)
                }
                //.onDelete(perform: MedicineHelper.removeMedicine(name: item.name))
                //                }.navigationBarTitle("List of Medicines").navigationBarHidden(self.navBarHidden)
                //                    .onAppear(perform: {
                //                        self.navBarHidden = true
                //                })
            }.navigationBarTitle("List of Medicines", displayMode: .inline)
            //.onDelete(perform: MedicineHelper.removeMedicine(name: medname))
        }
    }
    
    
    func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach { (i) in
            let name = self.items.items.sorted{ $0.name < $1.name }[i].name
            let pictureUrl = self.items.items.sorted{ $0.name < $1.name }[i].getPictureUrl()
            let ingredientsUrl = self.items.items.sorted{ $0.name < $1.name }[i].getIngredientsUrl()
            FileUtils.removeDataFile(filename:pictureUrl )
            FileUtils.removeDataFile(filename: ingredientsUrl)
            MedicineHelper.removeMedicine(name: name)
            let number = self.items.items.firstIndex(of:items.items.sorted{ $0.name < $1.name }[i])
            self.items.items.remove(at: number!)
        }
        todayMedicineList.load()
    }
}
//}


struct MedicineList_Previews: PreviewProvider {
    static var previews: some View {
        let schedule = MedicineSchedule()
        let med1 = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "square.and.pencil",schedule:schedule, startdate: "", enddate: "",totalcount: 1, expirydate: "",ingredientsUrl: "")
        let med2 = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "square.and.pencil",schedule:schedule, startdate: "", enddate: "",totalcount: 1, expirydate: "",ingredientsUrl: "")
        let med3 = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "square.and.pencil",schedule:schedule, startdate: "", enddate: "",totalcount: 1, expirydate: "",ingredientsUrl: "")
        let med4 = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "square.and.pencil",schedule:schedule, startdate: "", enddate: "",totalcount: 1, expirydate: "",ingredientsUrl: "")
        var items: [Medicine] = [med1,med2,med3,med4]
        return MedicineListView()
    }
}

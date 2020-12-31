//
//  MedicineDayView.swift
//  turmeric
//
//  Created by sriram palapudi on 9/18/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import SwiftUI

struct MedicineDayView: View {
    @EnvironmentObject var items: MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    @ObservedObject var notificationManager = LocalNotificationManager()
   // @ObservedObject var todayMedicineList = TodayMedicineList()
    @State var medicineNameTimeList = [MedicineNameTime]()
    @State var calData = CalendarData()
    @State var showMonth = false
    @State var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*60), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    //@State var todayMedicineList = MedicineList()
    @State var showFootnote = false
    @Environment(\.colorScheme) var colorScheme
    @State var showingMedicineLogView = false
    @State var med = Medicine()
    @State var boolVal = false
    @State var instructionsFlag = false
    @State var onAppearFlag = false
   // @State var list = [MedicineNameTime]()
    //item.getMedicine(name: item.name)
    var body: some View {
        return NavigationView {
            VStack{
                // List (items.items) { item in
                Spacer().frame(height:20).onAppear(perform: {self.todayMedicineList.load()})
 //               Spacer().frame(height:20).onAppear(perform: {self.onAppearFlag.toggle()})

                //                HStack{
//                    Spacer().frame(width:10)
//                    Button(action: {
//                        self.list = self.updateTodayMedicineList()
//                    }) {
//                        Image(systemName: "refresh")
//                        .resizable()
//                        .frame(width: 25, height: 20)
//                    }
//                    Spacer()
//                }
                List{
                    ForEach(todayMedicineList.todayMedicineListItems.sorted { $0.timeDate < $1.timeDate }, id:\.self) { (item) in
                        //todayMedicineList.getMedicineNameTime()
                        /* NavigationLink(destination: MedicineDetailView(med:item,schedule:item.schedule,timeslist: item.schedule.getTimesList(), dayslist: ["",""]  )) {*/
                        HStack{
                            if (item.taken == true){
                                HStack{
                                    TakenCheckboxField(
                                        id: item.name,
                                        label:"",
                                        size: 16,
                                        color: Color.green,
                                        textSize: 16,
                                        callback: checkboxSelected,
                                        timeStr: item.timeStr,
                                        boolVal:self.$boolVal,
                                        isMarked: true,
                                        medicineNameTime: item
                                        
                                    )
                                    Spacer().frame(width:15)
                                    Text("\(item.name)   \((self.boolVal ? "" : ""))").frame(width:160, alignment: .leading)
                                    Text(item.timeStr).frame(width:100)
                                    // Spacer().frame(height: 10)
                                    Spacer().frame(width:10)
                                }
                            } else {
                                HStack{
                                        TakenCheckboxField(
                                            id: item.name,
                                            label:"",
                                            size: 16,
                                            color: Color.red,
                                            textSize: 16,
                                            callback: checkboxSelected,
                                            timeStr: item.timeStr,
                                            boolVal: self.$boolVal,
                                            isMarked: false, //item.isMarked - need to add this to the medicinelist
                                            medicineNameTime: item
                                        )
                                    Spacer().frame(width:15)
                                    Text("\(item.name)   \((self.boolVal ? "" : ""))").frame(width:160, alignment: .leading)
                                    Text(item.timeStr).frame(width:100)
                                    Spacer().frame(width:10)
                                }
                            }
                        HStack{
                            NavigationLink(destination: MedicineLogView(name:item.name, previousView: self.$showingMedicineLogView).environmentObject(self.todayMedicineList)) {
                                Text("")
                            }
                        }
                    }
                    }
                }.buttonStyle(PlainButtonStyle())
            }.navigationBarTitle("List of Medicines for Today", displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
        
   func instructionsCheck() -> Void{
    let settings = MedicineHelper.getSettings()
    if settings[1] == "true" {
        instructionsFlag = true
    } else {
        instructionsFlag = false
    }
     }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct MedicineDayView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDayView()
    }
}
struct TakenCheckboxField: View {
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    var id: String
    var label: String
    var size: CGFloat
    @State var color: Color
    var textSize: Int
    var callback: (String, Bool,String)->()
    var timeStr : String
    @Binding var boolVal:Bool
    @State var isMarked:Bool
    @State var alertFlag = false
    @State var medicineNameTime: MedicineNameTime
    
    var body: some View {
        Button(action:{
            
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            var dateStr = formatter.string(from: currentDate)
            dateStr = dateStr +  " " + self.timeStr
            formatter.dateFormat = "MM/dd/yy hh:mm:ss a"
            formatter.timeZone = .current
            let medicineDate = formatter.date(from: dateStr)!
            
            if (medicineDate >  currentDate)  {
                self.alertFlag = true
            } else {
                self.isMarked.toggle()
                if self.isMarked == true{
                    self.color = Color.green
                    self.medicineNameTime.taken = true
                } else {
                    self.color = Color.red
                    self.medicineNameTime.taken = false
                }
                self.boolVal.toggle()
                self.callback(self.id, self.isMarked,self.timeStr)
                self.todayMedicineList.update(self.medicineNameTime)
                self.todayMedicineList.printItem("Checkbox ")
            }
        }) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .background(self.color)
                // .foregroundColor(self.color)
                //Text(label)
                // .font(Font.system(size: size))
                //Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(self.color)
        .alert(isPresented: self.$alertFlag) {
            Alert(title: Text("Important Message"), message: Text("This medicine is scheduled to be taken later. Please mark it as taken when you are notified."), dismissButton: .default(Text("Confirm")))
            
        }
    }
}

enum Taken {
    case Yes
    case No
}

func checkboxSelected(id: String, isMarked: Bool, timeStr : String) {
    let currentDate = Date()
    var weekDayString = ""
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: currentDate)
    if weekDay == 1{
        weekDayString = "Sun"
    }
    if weekDay == 2{
        weekDayString = "Mon"
    }
    if weekDay == 3{
        weekDayString = "Tue"
    }
    if weekDay == 4{
        weekDayString = "Wed"
    }
    if weekDay == 5{
        weekDayString = "Thu"
    }
    if weekDay == 6{
        weekDayString = "Fri"
    }
    if weekDay == 7{
        weekDayString = "Sat"
    }
    MedicineHelper.addMedicineLog(medicine: id, day: weekDayString, time: timeStr, taken: isMarked)
    
    
}

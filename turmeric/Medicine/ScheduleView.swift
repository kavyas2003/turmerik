//
//  ScheduleView.swift
//  turmeric
//
//  Created by kavya sriram on 9/19/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//
import SwiftUI
struct CheckboxField: View {
    var id: String
    var label: String
    var size: CGFloat
    var color: Color
    var textSize: Int
    var callback: (String, Bool)->()

    @State var isMarked:Bool
    
    //    init(
    //        id: String,
    //        label:String,
    //        size: CGFloat = 10,
    //        color: Color = Color.black,
    //        textSize: Int = 14,
    //        isMarked: Bool = false,
    //        callback: @escaping (String, Bool)->()
    //    ) {
    //        self.id = id
    //        self.label = label
    //        self.size = size
    //        self.color = color
    //        self.textSize = textSize
    //        self.callback = callback
    //        self.isMarked = true
    //    }
    
    /*  func getDayString ( d :Days ) -> String{
     var dayStr = String()
     switch d {
     case Days.M:
     dayStr = "Mon"
     break
     case Days.T:
     dayStr = "Tue"
     break
     case Days.W:
     dayStr = "Wed"
     break
     case Days.Th:
     dayStr = "Thu"
     break
     case Days.F:
     dayStr = "Fri"
     break
     case Days.Sa:
     dayStr = "Sat"
     break
     case Days.Su:
     dayStr = "Sun"
     break
     }
     return dayStr
     }*/
    
    
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.isMarked)
        }) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(self.color)
    }
}

enum Days {
    case M
    case T
    case W
    case Th
    case F
    case Sa
    case Su
}



struct ScheduleView: View {
    @Binding var previousView : Bool
    @State private var currentDate = Date()
    @State var showingsecondpicker = false
    @State var showingadd = false
    @Binding var dayslist : [String]
    //    @Binding var timeslist : [String]
    @Binding var timeslist : MedicineTimesList
   // @Binding var startDate: Date
    //@Binding var endDate: Date
   // @Binding var StringstartDate: String
   // @Binding var StringendDate: String
    @Binding var medname: String
    @State var formatter1 = DateFormatter()
    @State var isDisabled = false
    @State private var time1 = ""
    @State private var time2 = ""
    @State var deleteFlag = true
    @State var isCalendarPresented = false
    @State var toText = ""
    @State var dummyBoolVal = false
    @Environment(\.colorScheme) var colorScheme
    @Binding var rkManagerDateRange : RKManager
    @State var errorFlag = false
    @State var  errorMessageText = ""
    @State var expandFlag = true
 
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Medicine: \(medname)")
                HStack{
                    Button(action: {
                        
                        //                let calendar = Calendar.current
                        //                let hour1 = calendar.component(.hour, from: self.currentDate1)
                        //                let minute1 = calendar.component(.minute, from: self.currentDate1)
                        //                self.time1 = ("\(hour1):\(minute1)")
                        //                self.timeslist.append(self.time1)
                        //                let hour2 = calendar.component(.hour, from: self.currentDate2)
                        //                let minute2 = calendar.component(.minute, from: self.currentDate2)
                        //                let time2 = ("\(hour2):\(minute2)")
                        //                self.timeslist.append(time2)
                        //                self.formatter1.dateStyle = .short
                        //                self.StringstartDate = self.formatter1.string(from: self.startDate)
                        //                self.StringendDate = self.formatter1.string(from: self.endDate)
                        self.previousView.toggle()
                        
                    }) {
                        Text("Cancel")
                    }
                    Spacer().onAppear(perform: ({}))
                    Button(action: {
                        self.errorMessageText = ""
                        self.errorFlag = false
                        if ((self.rkManagerDateRange.endDate == nil) || (self.rkManagerDateRange.startDate == nil)) && self.dayslist.isEmpty == true{
                            self.errorFlag = true
                            self.errorMessageText.append("You have selected a start date and an end date or selected at least one day. \n")
                            
                        }
                        if self.timeslist.getTimes().isEmpty == true {
                            self.errorFlag = true
                            self.errorMessageText.append("You have added at least one time for this medicine. \n")
                        }
                        
                        //                let calendar = Calendar.current
                        //                let hour1 = calendar.component(.hour, from: self.currentDate1)
                        //                let minute1 = calendar.component(.minute, from: self.currentDate1)
                        //                self.time1 = ("\(hour1):\(minute1)")
                        //                self.timeslist.append(self.time1)
                        //                let hour2 = calendar.component(.hour, from: self.currentDate2)
                        //                let minute2 = calendar.component(.minute, from: self.currentDate2)
                        //                let time2 = ("\(hour2):\(minute2)")
                        //                self.timeslist.append(time2)
                        //                self.formatter1.dateStyle = .short
                        //                self.StringstartDate = self.formatter1.string(from: self.startDate)
                        //                self.StringendDate = self.formatter1.string(from: self.endDate)
                        if self.errorFlag == false{
                        self.previousView.toggle()
                        }
                       // if ((self.rkManagerDateRange.endDate != nil) && (self.rkManagerDateRange.startDate != nil)){
                       // self.startDate = self.rkManagerDateRange.startDate
                        //self.endDate = self.rkManagerDateRange.endDate
                          //  print(" SD:  \(self.startDate)) ED: \(self.endDate)")
                            
                        //}
                        
                    }) {
                        Text("Save")
                    }.alert(isPresented: $errorFlag){
                         Alert(title: Text("Please make sure the following is accurate:"), message: Text(errorMessageText), dismissButton: .default(Text("Confirm")))
                    }
                }
                //           HStack(alignment : .firstTextBaseline){
                Spacer().frame(height:20)
                Button(action: {
                    self.isCalendarPresented.toggle()
//                    if ((self.rkManagerDateRange.endDate != nil) && (self.rkManagerDateRange.startDate != nil)){
//                    self.endDate = self.rkManagerDateRange.endDate
//                    self.startDate = self.rkManagerDateRange.startDate
//                    }
                    self.dummyBoolVal.toggle()
                   // if self.getTextFromDate(date: self.rkManagerDateRange.startDate) != "" {
                     //   self.toText = "to"
                    //}
                }) {
                    //                  HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 10)
                    Text("Date Range")//.padding(.leading, 0)
                    if ((getTextFromDate(date:self.rkManagerDateRange.endDate)) != "" && (getTextFromDate(date: self.rkManagerDateRange.startDate)) != ""){
                        Text(" \((self.dummyBoolVal ?  "" : "")) \(self.getTextFromDate(date: self.rkManagerDateRange.startDate)) to  \(self.getTextFromDate(date: self.rkManagerDateRange.endDate))")
                    } else {
                        
                    Text("\(self.getTextFromDate(date: self.rkManagerDateRange.startDate))  \(self.getTextFromDate(date: self.rkManagerDateRange.endDate))")
                    
                    }
                    Spacer()
                    //                  }
                }//.frame(width: 120, alignment: .topLeading)
                    .sheet(isPresented: self.$isCalendarPresented, content: {
                        RKViewController(isPresented: self.$isCalendarPresented, rkManager: self.rkManagerDateRange)})
                
                Spacer().frame(height:20)
                //          }
                /*              HStack(alignment : .firstTextBaseline){
                 Spacer().frame(width: 10)
                 Text("Start Date").frame(width: 120, alignment: .topLeading)
                 //TextField(CurrentDate(date: Date()), text: $stringexpirydate)
                 TextField(CurrentDate(date: Date()), text: $StringstartDate)
                 }
                 
                 
                 HStack(alignment : .firstTextBaseline){
                 Spacer().frame(width: 10)
                 Text("End Date").frame(width: 120, alignment: .topLeading)
                 //TextField(CurrentDate(date: Date()), text: $stringexpirydate)
                 TextField(FutureDate(day:0,month:0,year:1), text: $StringendDate)
                 }
                 
                 */
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 10)
                    Text("Select Days:").frame(width: 120, alignment: .topLeading)
                    Spacer().frame(width: 220)
                }
                
                HStack {
                    if (dayslist.contains("Mon") || dayslist.contains("M")) {
                        CheckboxField(
                            id: "M",
                            label: "Mon",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        CheckboxField(
                            id: "M",
                            label: "Mon",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    
                    if (dayslist.contains("Tue") || dayslist.contains("T")) {
                        CheckboxField(
                            id: "T",
                            label: "Tue",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        CheckboxField(
                            id: "T",
                            label: "Tue",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    if (dayslist.contains("Wed") || dayslist.contains("W")) {
                        CheckboxField(
                            id: "W",
                            label: "Wed",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        CheckboxField(
                            id: "W",
                            label: "Wed",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    if (dayslist.contains("Thu") || dayslist.contains("Th")) {
                        CheckboxField(
                            id: "Th",
                            label: "Thu",
                            size: 16,
                            color:(colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        
                        CheckboxField(
                            id: "Th",
                            label:"Thu",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    if (dayslist.contains("Fri") || dayslist.contains("F")) {
                        CheckboxField(
                            id: "F",
                            label: "Fri",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        
                        CheckboxField(
                            id: "F",
                            label:"Fri",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    if (dayslist.contains("Sat") || dayslist.contains("Sa")) {
                        CheckboxField(
                            id: "Sa",
                            label: "Sat",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        
                        CheckboxField(
                            id: "Sa",
                            label:"Sat",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                    if (dayslist.contains("Sun") || dayslist.contains("Su")) {
                        CheckboxField(
                            id: "Su",
                            label: "Sun",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: true
                        )
                    } else {
                        
                        CheckboxField(
                            id: "Su",
                            label: "Sun",
                            size: 16,
                            color: (colorScheme == .dark ? Color.white : Color.black),
                            textSize: 16,
                            callback: checkboxSelected,
                            isMarked: false
                        )
                    }
                }
                
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 10)
                    Text("Select Time(s):").frame(width: 120, alignment: .topLeading)
                    Button(action: {
                        //self.showingsecondpicker.toggle()
                        let df = DateFormatter()
                        df.timeStyle = .medium
                        let str = df.string(from: self.currentDate)
                        let mt = MedicineTime(tim: str)
                        print(self.timeslist)
                        self.timeslist.addTimes(tim: mt)
                        print(self.timeslist)
                        print(self.timeslist.getTimes())
                    }) {
                        Image(systemName: "plus")
                        //Text("Add selected Time")
                    }
                    Spacer().frame(width: 220)
                }
                
                DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                //                Button(action: {
                //                    //self.showingsecondpicker.toggle()
                //                    let df = DateFormatter()
                //                    df.timeStyle = .medium
                //                    let str = df.string(from: self.currentDate)
                //                    let mt = MedicineTime(tim: str)
                //                    print(self.timeslist)
                //                    self.timeslist.addTimes(tim: mt)
                //                    print(self.timeslist)
                //                    print(self.timeslist.getTimes())
                //                }) {
                //                    Image(systemName: "plus")
                //                    //Text("Add selected Time")
                //                }
                HStack(alignment: .firstTextBaseline){
                    Spacer().frame(width: 10)
                    TimesDropDown(timeslist,$timeslist,$deleteFlag, $expandFlag)
                    Spacer().frame(width: 190)
                }
            }
        }
        .padding()
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    func checkboxSelected(id: String, isMarked: Bool) {
        if id == "M"{
            if (isMarked) {
                self.dayslist.append("Mon")
            }
            else {
                if dayslist.contains("Mon"){
                    let index = self.dayslist.firstIndex ( of: "Mon" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "T"{
            if (isMarked) {
                self.dayslist.append("Tue")
            }
            else {
                if dayslist.contains("Tue"){
                    let index = self.dayslist.firstIndex ( of: "Tue" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "W"{
            if (isMarked) {
                self.dayslist.append("Wed")
            }
            else {
                
                if dayslist.contains("Wed"){
                    let index = self.dayslist.firstIndex ( of: "Wed" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "Th"{
            if (isMarked) {
                self.dayslist.append("Thu")
            }
            else {
                if dayslist.contains("Thu"){
                    let index = self.dayslist.firstIndex ( of: "Thu" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "F"{
            if (isMarked) {
                self.dayslist.append("Fri")
            }
            else {
                if dayslist.contains("Fri"){
                    let index = self.dayslist.firstIndex ( of: "Fri")!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "Sa"{
            if (isMarked) {
                self.dayslist.append("Sat")
            }
            else {
                if dayslist.contains("Sat"){
                    let index = self.dayslist.firstIndex ( of: "Sat" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
        if id == "Su"{
            if (isMarked) {
                self.dayslist.append("Sun")
            }
            else {
                if dayslist.contains("Sun"){
                    let index = self.dayslist.firstIndex ( of: "Sun" )!
                    self.dayslist.remove(at:index)
                }
            }
        }
    /*    if id == "End Date"{
            if (isMarked) {
                self.isDisabled.toggle()
            }
            else {
                
                self.isDisabled.toggle()
                stringEndDate = ""
            }
        } */
        print("\(id) is marked: \(isMarked)")
    }
    func CurrentDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    func FutureDate(day:Int, month:Int, year: Int) -> String {
        let currentDate = Date()
        var dc = DateComponents()
        dc.day = day
        dc.month = month
        dc.year = year
        let futureDate = Calendar.current.date(byAdding: dc, to: currentDate)
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: futureDate!)
    }
}


//struct ScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView()
//    }
//}

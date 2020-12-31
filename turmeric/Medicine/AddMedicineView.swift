//
//  AddView.swift
//  testproject1000
//
//  Created by kavya sriram on 6/20/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//
import SwiftUI

struct AddMedicineView: View {
    @EnvironmentObject var items:MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var schedule = MedicineSchedule()
    @State var photoImage = UIImage()
    @State var ingredientsImage = UIImage()
    @State var showingSchedule = false
    @State var isToggle: Bool = false
//    @State var expirydate = Date()
//    @State var startDate = Date()
//    @State var endDate = Date()
    @State var name = ""
    @State var dosage = ""
    @State var dosagetype = "Pills"
    @State var prescription = "Yes"
    @State var medicinetype = ""
    @State var dos = 0
    @State var stringcount = ""
    @State var count = 0
   // @State var prescriptionval = ""
    @State var purchaseinfo = ""
    @State private var selection = 1
    @State var dayslist = [String]()
    @State var timeslist = MedicineTimesList()
    @State var StringstartDate = ""
    @State var StringendDate = ""
    @State var formatter1 = DateFormatter()
    @State var stringexpirydate = ""
    @State var showingCamera = false
    @State var showingCamera1 = false
    @State var isPrescription = false
    var days: String = ""
    @State var addMode = true
    @State private var errorFlag = false
    //@State private var nameErrorFlag = false
    //@State private var expiryErrorFlag = false
   // @State private var countErrorFlag = false
    //@State private var startDateErrorFlag = false
    //@State private var endDateErrorFlag = false
    @State var errorMessageText = ""
    @State var imagesLoaded = false

    // @State var isSaved = false
    @State var isCalendarPresented = false
    @State var rkManagerExpiryDate = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*730), mode: 0)
    @State var rkManagerDateRange = RKManager(calendar: Calendar.current, minimumDate: Date() , maximumDate: Date().addingTimeInterval(60*60*24*730), mode: 1)
    var body: some View {
        ScrollView{
            VStack{
            VStack{
                Spacer().frame(height:20).onAppear(perform: {
                    if self.imagesLoaded == false{
                        self.photoImage = UIImage(systemName: "camera")!
                        self.ingredientsImage = UIImage(systemName: "camera")!
                        self.imagesLoaded = true
                    }
                })
                HStack{
                    Spacer().frame(width: 270)
                    Button(action: {
                        self.errorMessageText = String("")
                                               self.errorFlag = false
                        var itemsnamelist = [String]()
                        for item in self.items.items{
                            itemsnamelist.append(item.name)
                        }
                        if itemsnamelist.contains(self.name) {
                            self.errorFlag = true
                            self.errorMessageText.append(" A medicine with this name does not already exists. \n")
                        }
                        let dosagearray = self.dosage.split(separator: " ")
                        for item in dosagearray {
                            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            
                            if let intVal = Int(part) {
                                print("this is a number -> \(intVal)")
                                self.dos = intVal
                            }
                        }
                        let countarray = self.stringcount.split(separator: " ")
                        for item in countarray {
                            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            
                            if let intVal = Int(part) {
                                print("this is a number -> \(intVal)")
                                self.count = intVal
                            }
                        }
                       
                        if(self.name == ""){
                            self.errorFlag = true
                            self.errorMessageText.append(" The medicine has a name.\n")
                        }
                        
                        
                        if self.count <= 0 {
                            self.errorFlag = true
                            self.errorMessageText.append(" Your count is above zero.\n")
                        }
                        
                        /* let dateFormatterGet = DateFormatter()
                         dateFormatterGet.dateFormat = "MM/dd/yy"
                         
                         if dateFormatterGet.date(from: self.stringexpirydate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your dates are formatted as MM/dd/yy. \n")
                         
                         }*/
                        /*if dateFormatterGet.date(from: self.StringstartDate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your start date is formatted as MM/dd/yy. \n")
                         }
                         if dateFormatterGet.date(from: self.StringendDate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your end date is formatted as MM/dd/yy. \n")
                         }
                         */
                        
                        if self.errorFlag == false{
                            //self.stringexpirydate = self.formatter1.string(from: self.expirydate)
                            
                            //                  let data = ImagePicker.image.jpegData(compressionQuality: 1.0)
                            self.stringexpirydate = self.getTextFromDate(date: self.rkManagerExpiryDate.selectedDate)
                            self.StringstartDate = self.getTextFromDate(date: self.rkManagerDateRange.startDate)
                            self.StringendDate = self.getTextFromDate(date: self.rkManagerDateRange.endDate)
                            let data = self.photoImage.jpegData(compressionQuality: 1.0)
                            //IF data is nil, then don't write a file and make urlStr to be "NoFile" and treat it differently while getting file from medicine.
                            var urlStr = ""
                            if data == nil {
                                urlStr = GlobalConstants.EMPTY
                            } else {
                                urlStr = FileUtils.writeDataToFile(data: data!, filename: "\(self.name)medicine")
                            }
                            
                            let ingredientData = self.ingredientsImage.jpegData(compressionQuality: 1.0)
                            var ingredienturlStr = ""
                            if ingredientData == nil {
                                ingredienturlStr = GlobalConstants.EMPTY
                            } else {
                                ingredienturlStr = FileUtils.writeDataToFile(data: ingredientData!, filename: "\(self.name)ingredients")
                            }
                            //    print("\(self.name) 1 \(self.StringendDate)  22  \(self.StringendDate) 333 \(self.count) 4444 \(self.expirydate)")
                            let med1 = Medicine(name: self.name, dosage: self.dos, dosageType: self.dosagetype , type:self.medicinetype, prescription: self.prescription, purchaseinfo:self.purchaseinfo, pictureUrl: urlStr, schedule: MedicineSchedule(days: self.dayslist, times: self.timeslist.getTimes()), startdate: self.StringstartDate, enddate: self.StringendDate, totalcount: self.count, expirydate: self.stringexpirydate, ingredientsUrl: ingredienturlStr)
                            self.items.addMedicine(med: med1)
                            self.timeslist.removeTimes()
                            self.todayMedicineList.addMedicine(med1)
                            MedicineHelper.addMedicine(medicine:med1)
                            self.mode.wrappedValue.dismiss()

                        }
                    }) {
                        Text("Add")
                        // }
                    }.alert(isPresented: $errorFlag) {
                        Alert(title: Text("Please make sure the following is accurate:"), message: Text(errorMessageText), dismissButton: .default(Text("Confirm")))
                        
                    }
                }
                //
                Spacer().frame(width: 10)
            }
            
            
            Spacer().frame(height: 30)
            
            VStack(alignment: .leading){
                HStack(alignment: .lastTextBaseline){
                    Spacer().frame(width: 100)
                    VStack{
                        Text("Medicine")
                        Button(action:{
                            self.showingCamera.toggle()
                            //CameraView(photoImage: self.$photoImage)
                        }){
                            //                               initInternalVariables(vi: self)
                            Image(uiImage: self.photoImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .aspectRatio(contentMode: .fill)
                                
                                .sheet(isPresented: $showingCamera){
                                    CameraView(photoImage: self.$photoImage)
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer().frame(width: 50)
                    VStack{
                        Text("Ingredients")
                        Button(action:{
                            self.showingCamera1.toggle()
                            //CameraView(photoImage: self.$photoImage)
                        }){
                            Image(uiImage: self.ingredientsImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .aspectRatio(contentMode: .fit)
                                
                                .sheet(isPresented: $showingCamera1){
                                    CameraView(photoImage: self.$ingredientsImage)
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer().frame(width: 100)
                    
                }
                
                
                HStack{
                    Spacer().frame(width: 50)
                    Text("Name").frame(width: 120, alignment: .topLeading)
                    TextField("Name", text: $name)
                }
                HStack{
                    Spacer().frame(width: 50)
                    Text("Dosage").frame(width: 120, alignment: .topLeading)
                    TextField("Dosage (Number)", text: $dosage)
                }
                
                HStack(alignment : .firstTextBaseline) {
                    Spacer().frame(width: 50)
                    Text("Dosage Type").frame(width: 120, alignment: .topLeading)
                    DosageTypeDropDown(dosageType : self.$dosagetype, initialString: self.$dosagetype)
                }
                
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 50)
                    Text("Medicine Type").frame(width: 120, alignment: .topLeading)
                    TextField("Ex. Allergy or Asthma", text: $medicinetype)
                }
                
                HStack{
                    Spacer().frame(width:50)
                    Text("Prescription ").frame(width: 120, alignment: .topLeading)
                    
                    PrescriptionDropDown(prescription:self.$prescription, initialString: self.$prescription)
                    /* Section() {
                     Toggle(isOn: $isPrescription) {
                     Text("Prescription")
                     }
                     }*/
                    
                    Spacer().frame(width: 200)
                }
                
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 50)
                    Text("Purchase Info").frame(width: 120, alignment: .topLeading)
                    TextField("Ex. Date/Location", text: $purchaseinfo)
                }
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 50)
                    Text("Count").frame(width: 120, alignment: .topLeading)
                    TextField("Starting Amount", text: $stringcount)
                }
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 50)
                    //Text("Expiry Date").frame(width: 120, alignment: .topLeading)
                    Button(action: {
                        self.isCalendarPresented.toggle()
                       // if self.rkManagerExpiryDate.selectedDate == nil {
                          //  self.rkManagerExpiryDate.selectedDate = Date().addingTimeInterval(60*60*24*365)
                        
                       // }
                    }) {
                        //                  HStack(alignment : .firstTextBaseline){
                        //Spacer().frame(width: 10)
                        Text("Expiry Date ").padding(.leading, 0)
                        Spacer().frame(width:30)
                        Text("\(getTextFromDate(date: self.rkManagerExpiryDate.selectedDate))")
                        
                        //                  }
                    }//.frame(width: 120, alignment: .topLeading)
                        .sheet(isPresented: self.$isCalendarPresented, content: {
                            RKViewController(isPresented: self.$isCalendarPresented, rkManager: self.rkManagerExpiryDate)})
                    //TextField(CurrentDate(date: Date()), text: $stringexpirydate)
                    //TextField(FutureDate(day:0,month:0,year:1), text: $stringexpirydate)
                }
                HStack(alignment : .firstTextBaseline){
                    Spacer().frame(width: 50)
                    Text("Schedule").frame(width: 120, alignment: .topLeading)
                    
                    NavigationLink(destination: ScheduleView(previousView: self.$showingSchedule, dayslist: self.$dayslist, timeslist: self.$timeslist, medname: self.$name, rkManagerDateRange: self.$rkManagerDateRange),isActive: self.$showingSchedule){
                        HStack(alignment: .center){
                            //.frame(width: 10)
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 25, height: 20)
                            Spacer()
                        }
                    }
                    Button(action: {
                        self.showingSchedule.toggle()
                        self.timeslist.removeTimes()
                        
                    } ) {
                        Image(systemName: "calendar")
                    }.sheet(isPresented: $showingSchedule) {
                        ScheduleView(previousView: self.$showingSchedule, dayslist: self.$dayslist, timeslist: self.$timeslist, medname: self.$name, rkManagerDateRange: self.$rkManagerDateRange)
                        
                        }
                    }
                }
            }
        }.padding()
        .keyboardAdaptive()
    }
    
    
    //A function to initialize other struct or class variables
    //    func initInternalVariables (vi : AddMedicineView ) -> some View {
    //        let m = vi.med
    //        vi.photoImage = m.getMedicineImage()
    //        vi.ingredientsImage = m.getIngredientsImage()
    //        vi.schedule = m.getSchedule()
    //        vi.name = m.getName()
    //        vi.dosage = String(m.getDosage())
    //        vi.prescription = m.getPrescription()
    //        vi.medicinetype = m.getType()
    //        return EmptyView()
    //    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        return date == nil ? "" : formatter.string(from: date)
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
//struct AddMedicineView_Previews: PreviewProvider
//    @State private var navBarHidden = true
//    static var previews: some View {
//        AddMedicineView( navBarHidden: self.$navBarHidden)
//    }
//}

struct AddMedicineView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

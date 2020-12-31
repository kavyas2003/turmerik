//
//  MedicineDetail.swift
//  testproject1000
//
//  Created by kavya sriram on 6/14/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//
import SwiftUI


struct MedicineDetailView: View {
    //@State var showingHome = false
    @EnvironmentObject var items:MedicineList
    @EnvironmentObject var todayMedicineList : TodayMedicineList
    @State var med:Medicine
    
    @State var name = ""
    @State var picture = UIImage()
    @State var ingredientsPicture = UIImage()
    @State var dosage = ""
    @State var dosageVal = 0
    @State var countVal = 0
    @State var count = ""
    @State var prescriptionval = ""
    @State var totalcount = Int()
    @State var dosageType = String()
    @State var schedule = MedicineSchedule()
    @State var prescription = String()
    @State var purchaseinfo = String()
    @State var pictureUrl = String()
    @State var ingredientsUrl = String()
    @State var activeingredients =  String()
    @State var passiveingredients = String()
    @State var startdate = Date()
    @State var enddate = Date()
    @State var stringexpirydate = String()
    @State var medicineType = String()
    @State var stringStartDate = ""
    @State var stringEndDate = ""
    @State var timeslist : MedicineTimesList
    @State var showingSchedule = false
    @State var showingMedicineLogView = false
    @State var isDisabled = true
    //@State var dayslist: [String]
    //@State var editMode: EditMode = .inactive
    @State var editButtonText = "Edit"
    @State var showingCamera = false
    @State var showingPictureCamera = false
    @State var showingIngredientsCamera = false
    @State var showingIngredientsImageDetail = false
    @State var showingMedicineImageDetail = false
    @State var daysList: [String]
    @State var timesList:  [String]
    @State var mdvFlag = true
    @State var isCalendarPresented = false
    @State var imageSheetMode = ""
    @State var deleteFlag = false
    @State var ingredientsImageSheetMode = ""
    @State private var errorFlag = false
    @State private var nameErrorFlag = false
    @State private var expiryErrorFlag = false
    @State private var countErrorFlag = false
    @State private var startDateErrorFlag = false
    @State private var endDateErrorFlag = false
    @State var errorMessageText = ""
    @State var isSaved = false
    @State var rkManagerExpiryDate = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*730), mode: 0)
    @State var rkManagerDateRange = RKManager(calendar: Calendar.current, minimumDate: Date() , maximumDate: Date().addingTimeInterval(60*60*24*730), mode: 1)
    @State var expandFlag = false
    
    //@State var medCopy:Medicine =  Medicine()
    
    var body: some View {
        ScrollView {
            VStack{
                Spacer().frame(height: 20)
                HStack{
                    
                    Button(action:  {
                        self.isDisabled.toggle()
                        if self.isDisabled == true{
                            self.editButtonText = "Edit"
                        } else {
                            self.editButtonText = "Cancel"
                        }
                        //AddMedicineView()
                    }) {
                        Text(editButtonText)
                    }
                    Spacer().frame(width:250)
                    Button(action:  {
                        let dosagearray = self.dosage.split(separator: " ")
                        for item in dosagearray {
                            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            if let intVal = Int(part) {
                                print("this is a number -> \(intVal)")
                                self.dosageVal = intVal
                            }
                        }
                        let countarray = self.count.split(separator: " ")
                        for item in countarray {
                            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                            
                            if let intVal = Int(part) {
                                print("this is a number -> \(intVal)")
                                self.countVal = intVal
                            }
                        }
                        self.errorMessageText = String("")
                        self.errorFlag = false
                        if(self.name == ""){
                            self.errorFlag = true
                            self.errorMessageText.append(" The medicine has a name. \n")
                        }
                        if self.countVal <= 0 {
                            self.errorFlag = true
                            self.errorMessageText.append(" Your count is above zero. \n")
                        }
                        /*   let dateFormatterGet = DateFormatter()
                         dateFormatterGet.dateFormat = "MM/dd/yy"
                         
                         if dateFormatterGet.date(from: self.expirydate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your expiry date is formatted as MM/dd/yy. \n")
                         }*/
                        /* if dateFormatterGet.date(from: self.startdate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your start date is formatted as MM/dd/yy. \n")
                         }
                         if dateFormatterGet.date(from: self.enddate) == nil {
                         self.errorFlag = true
                         self.errorMessageText.append(" Your end date is formatted as MM/dd/yy. \n")
                         }*/
                        
                        //updating stuff
                        if self.errorFlag == false{
                            self.stringexpirydate = self.getTextFromDate(date: self.rkManagerExpiryDate.selectedDate)
                            self.stringStartDate = self.getTextFromDate(date: self.rkManagerDateRange.startDate)
                            self.stringEndDate = self.getTextFromDate(date: self.rkManagerDateRange.endDate)
                            let data = self.picture.jpegData(compressionQuality: 1.0)
                            //IF data is nil, then don't write a file and make urlStr to be "NoFile" and treat it differently while getting file from medicine.
                            var urlStr = ""
                            if data == nil {
                                urlStr = GlobalConstants.EMPTY
                            } else {
                                urlStr = FileUtils.writeDataToFile(data: data!, filename: "\(self.name)medicine")
                            }
                            
                            let ingredientData = self.ingredientsPicture.jpegData(compressionQuality: 1.0)
                            var ingredienturlStr = ""
                            if ingredientData == nil {
                                ingredienturlStr = GlobalConstants.EMPTY
                            } else {
                                ingredienturlStr = FileUtils.writeDataToFile(data: ingredientData!, filename: "\(self.name)ingredients")
                            }
                            //print("\(self.name) 1 \(self.StringendDate)  22  \(self.StringendDate) 333 \(self.count) 4444 \(self.expirydate)")
                            let med1 = Medicine(name: self.name, dosage: self.dosageVal, dosageType: self.dosageType , type:self.medicineType, prescription: self.prescription, purchaseinfo:self.purchaseinfo, pictureUrl: urlStr, schedule: MedicineSchedule(days: self.daysList, times: self.timeslist.getTimes()), startdate: self.stringStartDate, enddate: self.stringEndDate, totalcount: self.countVal, expirydate: self.stringexpirydate, ingredientsUrl: ingredienturlStr)
                            
                            self.items.removeMedicine(med: med1)
                            MedicineHelper.updateMedicine(medicine: med1)
                            self.items.addMedicine(med: med1)
                            self.todayMedicineList.updateMedicine(med1)

                            self.isDisabled.toggle()
                            if self.isDisabled == true{
                                self.editButtonText = "Edit"
                            } else {
                                self.editButtonText = "Cancel"
                            }
                          
                        }
                    }) {
                        Text("Save")
                    }.disabled(isDisabled)
                        .alert(isPresented: $errorFlag) {
                            Alert(title: Text("Please make sure the following is accurate:"), message: Text(errorMessageText), dismissButton: .default(Text("Confirm")))
                    }
                    //.sheet(isPresented: $isSaved){
                    //  MedicineListView().environmentObject(self.items)
                    // }
                    Spacer().frame(width:10)
                }
            }
            
            HStack(alignment: .lastTextBaseline){
                Spacer().frame(width: 100).onAppear(perform: {self.setMedicineCopy(med:self.med)})
                VStack{
                    Text("Medicine")
                    Button(action:{
                        self.showingPictureCamera.toggle()
                        self.imageSheetMode = ""
                        if(self.isDisabled != true) {
                            self.imageSheetMode = "Album"
                        }
                    }){
                        Image(uiImage: self.picture)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            
                            
                            .sheet(isPresented: $showingPictureCamera){
                                if (self.imageSheetMode == "Album") {
                                    CameraView(photoImage: self.$picture)
                                } else {
                                    ImageDetailView(showingImageDetail: self.showingMedicineImageDetail, picture: self.picture)
                                }
                        }
                        //                            .sheet(isPresented: $showingMedicineImageDetail) {
                        //                                ImageDetailView(showingImageDetail: self.showingMedicineImageDetail, picture: self.picture)
                        //                            }
                        
                    }.buttonStyle(PlainButtonStyle())
                    //                   .disabled(isDisabled)
                    
                }
                Spacer().frame(width: 50)
                VStack{
                    Text("Ingredients")
                    Button(action:{
                        self.showingIngredientsCamera.toggle()
                        self.ingredientsImageSheetMode = ""
                        if(self.isDisabled != true) {
                            self.ingredientsImageSheetMode = "Album"
                        }
                        
                    }){
                        Image(uiImage: self.ingredientsPicture)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            
                            .sheet(isPresented: $showingIngredientsCamera){
                                if(self.ingredientsImageSheetMode == "Album"){
                                    CameraView(photoImage: self.$ingredientsPicture)
                                }else {
                                    ImageDetailView(showingImageDetail: self.showingIngredientsImageDetail, picture: self.ingredientsPicture)
                                }
                        }
                        //                        .sheet(isPresented: $showingIngredientsImageDetail) {
                        //                            ImageDetailView(showingImageDetail: self.showingIngredientsImageDetail, picture: self.ingredientsPicture)
                        //                        }
                    }.buttonStyle(PlainButtonStyle())
                    //                  .disabled(isDisabled)
                    
                }
                Spacer().frame(width: 100)
                
            }
            
            
            VStack(alignment: .leading){
                Spacer().frame(height: 20)
                NavigationLink(destination: MedicineLogView(name: med.name, previousView: self.$showingMedicineLogView).environmentObject(self.todayMedicineList),isActive: self.$showingMedicineLogView){
                    HStack{
                        Spacer().frame(width: 45)
                        Text("Medicine Logs").frame(width: 120)
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Spacer().frame(width: 255)
                    }
                }
                NavigationLink(destination: ScheduleView(previousView: self.$showingSchedule, dayslist: self.$daysList, timeslist: self.$timeslist, medname: $med.name, rkManagerDateRange: self.$rkManagerDateRange),isActive: self.$showingSchedule){
                    HStack{
                        Spacer().frame(width: 50)
                        Text("Edit Schedule ").frame(width: 115)
                        //.frame(width: 10)
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .disabled(isDisabled)
                        Spacer().frame(width: 255)
                    }
                }.disabled(isDisabled)
                Spacer()
                VStack{
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Day(s): ").frame(width: 120, alignment: .topLeading)
                        Text(String(describing: daysList))
                        Spacer().frame(width: 50)
                    }
                }
                Spacer()
                VStack{
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        TimesDropDown(timeslist, $timeslist, $deleteFlag, $expandFlag)

                        }

                    }

                  VStack(alignment: .leading) {

                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Count: ").frame(width: 120, alignment: .topLeading)
                        TextField("Count",text: $count).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }
                   /* HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Expiry Date: ").frame(width: 120, alignment: .topLeading)
                        
                        //TextField("Expiry Date", text: $expirydate).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }*/
                    
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        
                        Button(action: {
                            self.isCalendarPresented.toggle()
                        }) {
                            //                  HStack(alignment : .firstTextBaseline){
                            //Spacer().frame(width: 10)
                            //Text("Expiry Date ").padding(.leading, 0)
                            Text("Expiry Date:").frame(width: 120, alignment: .topLeading)
                            Spacer().frame(width:30)
                            Text("\(getTextFromDate(date: self.rkManagerExpiryDate.selectedDate))")
                            
                            //                  }
                        }//.frame(width: 120, alignment: .topLeading)
                            .sheet(isPresented: self.$isCalendarPresented, content: {
                                RKViewController(isPresented: self.$isCalendarPresented, rkManager: self.rkManagerExpiryDate)})
                        .disabled(isDisabled)
                        //TextField(CurrentDate(date: Date()), text: $stringexpirydate)
                        //TextField(FutureDate(day:0,month:0,year:1), text: $stringexpirydate)
                    }
                    
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Type: ").frame(width: 120, alignment: .topLeading)
                        TextField("Type",text: $medicineType).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Dosage: ").frame(width: 120, alignment: .topLeading)
                        TextField("Dosage",text: $dosage).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }
                    HStack(alignment : .firstTextBaseline) {
                        Spacer().frame(width: 50)
                        Text("Dosage Type").frame(width: 120, alignment: .topLeading)
                        DosageTypeDropDown(dosageType : $dosageType, initialString: $dosageType).disabled(isDisabled)
                    }
                    
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Prescription: ").frame(width: 120, alignment: .topLeading)
                        PrescriptionDropDown(prescription: $prescription, initialString: $prescription).disabled(isDisabled)
                        //TextField("Prescription", text: $prescription).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }
                    HStack(alignment : .firstTextBaseline){
                        Spacer().frame(width: 50)
                        Text("Purchase Info: ").frame(width: 120, alignment: .topLeading)
                        TextField("Purchase Info", text: $purchaseinfo).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                    }
                    
                    /*                  HStack(alignment : .firstTextBaseline){
                     Spacer().frame(width: 50)
                     Text("Start Date: ").frame(width: 120, alignment: .topLeading)
                     TextField("Start Date", text: $startdate).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                     }
                     HStack(alignment : .firstTextBaseline){
                     Spacer().frame(width: 50)
                     Text("End Date: ").frame(width: 120, alignment: .topLeading)
                     TextField("End Date", text: $enddate).frame(width: 120, alignment: .topLeading).disabled(isDisabled)
                     }
                     */
                    
                }
            }
        }.navigationBarTitle(med.getName()).padding()
            .keyboardAdaptive()
        
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yy"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    func setMedicineCopy(med:Medicine) -> Void {
        if(self.mdvFlag == true) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            self.name = med.getName()
            self.picture = med.getMedicineImage()
            self.ingredientsPicture = med.getIngredientsImage()
            self.dosage = String(med.getDosage())
            self.count = String(med.getTotalCount())
            self.dosageType = med.getDosageType()
            self.schedule = med.getSchedule()
            self.prescription = med.getPrescription()
            self.purchaseinfo = med.getPurchaseinfo()
            self.pictureUrl = med.getPictureUrl()
            self.ingredientsUrl = med.getIngredientsUrl()
            self.activeingredients =  med.getActiveIngredients()
            self.passiveingredients = med.getPassiveIngredients()
            self.stringStartDate = med.getStartDate()
            self.stringEndDate = med.getEndDate()
            self.stringexpirydate = med.getExpiryDate()
            self.medicineType = med.getType()
            self.daysList = med.schedule.days
            // self.timesList = med.schedule.times
            self.timeslist = med.schedule.getTimesList()
            self.mdvFlag = false
            //            self.startdate = formatter.date(from: stringStartDate)!
            //            self.enddate = formatter.date(from: stringEndDate)!
            self.rkManagerDateRange.startDate = formatter.date(from: med.getStartDate())
            self.rkManagerDateRange.endDate = formatter.date(from: med.getEndDate())
            self.rkManagerExpiryDate.selectedDate = formatter.date(from: med.getExpiryDate())
            
        }
    }
}


struct MedicineDetail_Previews: PreviewProvider {
    static var previews: some View {
        let schedule = MedicineSchedule()
        
        let med = Medicine(name: "Albuterol", dosage: 1, dosageType: "Pill", type: "Ashtma", prescription: "", purchaseinfo:"None", pictureUrl: "System.circle",schedule:schedule, startdate: "", enddate: "",totalcount: 1, expirydate: "",ingredientsUrl: "")
        let timeslist = schedule.getTimesList()
        return MedicineDetailView(med:med,schedule:med.schedule, timeslist: timeslist, daysList: ["",""], timesList: ["",""])
    }
}

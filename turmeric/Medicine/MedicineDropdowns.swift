//
//  MedicineDropdowns.swift
//  turmeric
//
//  Created by sriram palapudi on 10/9/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
import SwiftUI

struct DosageTypeDropDown: View {
    
    @State var expand = false
    @Binding var dosageType : String
    @Binding var initialString : String
    
    var body: some View {
        VStack() {
            //           Spacer()
            VStack(spacing: 10) {
                HStack() {
                    Text(initialString)
                    //                        .fontWeight(.bold)
                    //                        .foregroundColor(.white)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                    //                        .foregroundColor(.white)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    Button(action: {
                        self.expand.toggle()
                        self.dosageType = "Pills"
                    }) {
                        Text("Pills")
                    }
                    Button(action: {
                        self.expand.toggle()
                        self.dosageType = "Puffs"
                    }) {
                        Text("Puffs")
                    }
                    Button(action: {
                        self.expand.toggle()
                        self.dosageType = "Tea Spoon"
                    }) {
                        Text("Tea Spoon")
                    }
                    Button(action: {
                        self.expand.toggle()
                        self.dosageType = "Table Spoon"
                    }) {
                        Text("Table Spoon")
                    }
                    Button(action: {
                        self.expand.toggle()
                        self.dosageType = "Other"
                    }) {
                        Text("Other")
                    }
                    
                }
            }
            //               .padding()
            //           .background(LinearGradient(gradient: .init(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
            //           .cornerRadius(15)
            //           .shadow(color: .gray, radius: 5)
            //           .animation(.spring())
        }
    }
}

struct TimesDropDown: View {
    
   // @State var expand: Bool
    @Binding var selectedTimes : MedicineTimesList
    @ObservedObject var o : MedicineTimesList
    @Binding var deleteFlag : Bool
    @Binding var expand: Bool
    
    init(_ observedTimesList: MedicineTimesList, _ selectedTimes: Binding<MedicineTimesList>,_ deleteFlag: Binding<Bool>, _ expand: Binding<Bool>) {
        self.o = observedTimesList
        self._selectedTimes = selectedTimes
        self._deleteFlag = deleteFlag
        self._expand = expand
    }
    
    
    //    @State var items = [Item(item: "8"), Item(item: "5"), Item(item: "10")]
    var body: some View {
        VStack() {
            HStack() {
                Text("Selected Times")
                //                        .fontWeight(.bold)
                //                        .foregroundColor(.white)
                Image(systemName: expand ? "chevron.up" : "chevron.down")
                    .resizable()
                    .frame(width: 13, height: 6)
                //                        .foregroundColor(.white)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                List (o.times) { tims in
                    //                        self.debug(str: self.selectedTimes.getTimes().joined(separator: ","))
                    Text(tims.time)
                    if(self.deleteFlag) {
                        Image(systemName: "minus.circle.fill").onTapGesture {
                            self.selectedTimes.removeTime(time: tims)
                        }
                    }
                }.frame(minHeight: 50 * 5)
            }
        }
    }
    
    private func debug(str:String) -> some View {
        print(str)
        return EmptyView()
    }
    
}



class MedicineTimesList : ObservableObject {
    @Published var times = [MedicineTime]()
    
    func addTimes(tim:MedicineTime) {
        if !times.contains(tim) {
            times.append(tim)
        }
    }
    
    func getTimes() -> [String] {
        var strArr = [String]()
        for time in times {
            strArr.append(time.time)
        }
        return strArr
    }
    
    func removeTimes() {
        times.removeAll()
    }
    
    func removeTime(time:MedicineTime) {
        if let index = times.firstIndex(of: time) {
            times.remove(at: index)
        }
    }
}

class MedicineTime : Identifiable,Equatable{
    var time : String
    init(tim:String) {
        self.time = tim
    }
    
    static func ==(lhs: MedicineTime, rhs: MedicineTime) -> Bool {
        return lhs.time == rhs.time
    }
}

struct PrescriptionDropDown: View {
    
    @State var expand = false
    @Binding var prescription : String
    @Binding var initialString : String
    
    var body: some View {
        VStack() {
            //           Spacer()
            VStack(spacing: 10) {
                HStack() {
                    Text(initialString)
                    //                        .fontWeight(.bold)
                    //                        .foregroundColor(.white)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                    //                        .foregroundColor(.white)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    Button(action: {
                        self.expand.toggle()
                        self.prescription = "Yes"
                    }) {
                        Text("Yes")
                    }
                    Button(action: {
                        self.expand.toggle()
                        self.prescription = "No"
                    }) {
                        Text("No")
                    }
                    
                }
            }
            //               .padding()
            //           .background(LinearGradient(gradient: .init(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
            //           .cornerRadius(15)
            //           .shadow(color: .gray, radius: 5)
            //           .animation(.spring())
        }
    }
}

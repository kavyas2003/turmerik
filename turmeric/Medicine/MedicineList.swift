//
//  MedicineList.swift
//  turmeric
//
//  Created by sriram palapudi on 9/14/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation

class MedicineList: ObservableObject {
    @Published var items = [Medicine]()
    
    func addMedicine(med:Medicine) {
        items.append(med)
    }
    
    func removeMedicine(med:Medicine) {
        if let index = items.firstIndex(of: med) {
            items.remove(at: index)
        }
    }
    
    func load() {
        for item in items{
            removeMedicine(med: item)
        }
        items = MedicineHelper.getAllMedicine()
    }
}

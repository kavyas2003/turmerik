//
//  FileUtils.swift
//  turmeric
//
//  Created by sriram palapudi on 9/12/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
import SwiftUI

class FileUtils {
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func readDataFromFile(filename:String,namedValue:String) -> Data {
        let imgPath = FileUtils.getDocumentsDirectory().appendingPathComponent(filename)
        var data: Data?
        try? data  = Data(contentsOf: imgPath)
        if(data == nil ) {
            data = UIImage(named: namedValue)?.jpegData(compressionQuality: 1)
        }
        return data!
    }
    
    static func getFilePath(filename:String) -> URL {
        let imgPath = FileUtils.getDocumentsDirectory().appendingPathComponent(filename)
        return imgPath
    }
    
    static func writeDataToFile(data:Data, filename:String) -> String{
        let imgPath = FileUtils.getDocumentsDirectory().appendingPathComponent(filename)
        try? data.write(to: imgPath)
        print("Writing ")
        return filename
    }
    
    static func removeDataFile( filename:String) {
        let filemanager = FileManager.default
        do {
            if filemanager.fileExists(atPath: filename) {
                try filemanager.removeItem(atPath : filename)
            }
        } catch {
            print("File delete did not happen")
        }
        print("Remove '\(filename)' ")
    }
}


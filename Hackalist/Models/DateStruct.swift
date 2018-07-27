//
//  DateStruct.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/27/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation


struct DateStruct : Codable {
    
    var month: String 
    var year: String
    
    init(month: String, year: String) {
        self.month = month
        self.year = year
    }
    
}





extension DateStruct {
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("hackatonDateSaved").appendingPathExtension("plist")
    
    
    static func saveToFile(list: DateStruct) {
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedHackaton = try? propertyListEncoder.encode(list)
        try? encodedHackaton?.write(to: DateStruct.archiveURL, options: .noFileProtection)
    }
    
    
    static func loadFromFile() -> DateStruct? {
        
        guard let codedDate = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(DateStruct.self, from: codedDate)
    }
    
}







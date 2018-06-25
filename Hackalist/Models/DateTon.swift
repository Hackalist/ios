//
//  DateTon.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/23/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation



//MARK: Date singleton, if we can name this a singleton...


class DateTon {
    
    static let sharedDate = DateTon()
    //MARK: Our date.
    let now = Date()
    //MARK: Calendar instance we will operate with.
    let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
    
    
    
    //MARK: "Asking" the calendar instance what month are we in today's date.
    func getTheMonth() -> Int {
        return (self.calendar?.component(NSCalendar.Unit.month, from: now))!
    }
    //MARK: Same for the year.
    func getTheYear() -> Int {
        return (self.calendar?.component(NSCalendar.Unit.year, from: now))!
    }
    
    
    //MARK: DateFormatter for month format in String.
    func getTheMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: now)
    }
}








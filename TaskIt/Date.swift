//
//  DateHelper.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation

class Date {
    
    class func from(year:Int, month:Int, day:Int) -> NSDate {
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCal = NSCalendar(identifier: NSGregorianCalendar)!
        return gregorianCal.dateFromComponents(components)!
    }
    
    class func stringFromDate(date: NSDate) -> String {
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
}
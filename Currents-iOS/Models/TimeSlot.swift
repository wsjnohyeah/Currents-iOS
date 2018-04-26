//
//  TimeSlot.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/26/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import Foundation

class TimeSlot {
    var from:Date
    var to:Date
    
    /*
     * Initializes the timeslot with Date objects
     * - Requires: The two dates must be on the same day
     */
    init(from:Date, to: Date) {
        self.from = from
        self.to = to
    }
    
    /*
     * Initializes the timeslot object with dates in string format.
     * - Requires: The format of the string should be "yyyy-MM-dd HH:mm"
     & - Requires: The two dates must be on the same day.
     * - from: the string of the start time of the time slot
     * - to: the string of the end time of the time slot
     */
    init(from:String, to: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        self.from = formatter.date(from: from) ?? Date()
        self.to = formatter.date(from: to) ?? Date()
    }
    
    /*
     * Returns the start time of the timeslot in the form of "hh:mm a"
     */
    func getStartTimeHourMinute() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter.string(from: from)
    }
    
    /*
     * Returns the end time of the timeslot in the form of "hh:mm a"
     */
    func getEndTimeHourMinute() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter.string(from: to)
    }
    
    /*
     * Returns the month and day of the current time slot in the form "Jan 31"
     */
    func getMonthDay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM. dd"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        return formatter.string(from: from)
    }
}

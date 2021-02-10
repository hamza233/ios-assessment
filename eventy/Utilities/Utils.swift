//
//  Utils.swift
//  eventy
//
//  Created by Hamza Mahmood on 2/9/21.
//

import Foundation

class Utils {
    // take the string date in yyyy-mm-dd formate and output dayname, dd-mm-yyyy. ex, Monday 1/1/2020
    static func convertDate(stringDate: String) -> String{
        let df  = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = df.date(from: stringDate)!
                                                    // set the format to EEEE to get the day name
        df.dateFormat = "EEEE"
        let day = df.string(from: date)
        df.dateFormat = "dd-MM-YYYY"
        return day + ", " + df.string(from: date);
    }
    
    // take the time in 00:00 formate and output in formate 1:30 PM
    static  func convertTime(stringTime: String)-> String{
        var period: String                          // am or pm
        var hour = Int(stringTime.prefix(2))        // first two chars of string are hour
        let min = String(stringTime.suffix(2))      // last two chars are min
        if (hour! >= 12) {                          // determine AM or PM
            period = "PM"
        }else {
            period = "AM"
        }
        
        hour = hour! % 12                           // convert to 12 hour format
        if (hour == 0){                             // hour will be 00 at 12 am
            hour = 12
        }
        return hour!.description + ":" + min + " " + period
    }
}

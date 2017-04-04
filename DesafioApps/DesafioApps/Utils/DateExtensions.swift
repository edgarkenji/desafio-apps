//
//  DateExtensions.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation

extension Date {
  
  init?(year:Int, month:Int, day:Int, hour:Int? = 0, minutes:Int? = 0, seconds:Int? = 0, timezoneSecondsFromGMT:Int = 0) {
    var calendar = NSCalendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: timezoneSecondsFromGMT)!
    let components = DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: minutes, second: seconds)
    
    guard let date = calendar.date(from: components) else {
      return nil
    }
    self.init(timeIntervalSince1970: date.timeIntervalSince1970)
  }
  
}

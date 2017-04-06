//
//  DateUtils.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation

class DateUtils {
  static let ISO8601Formatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
  
  static let ReadableFormatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
  }()
  
  static func readableDate(date:Date) -> String {
    return ReadableFormatter.string(from: date)
  }
}

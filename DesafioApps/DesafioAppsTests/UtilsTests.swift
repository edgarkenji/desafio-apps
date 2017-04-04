//
//  UtilsTests.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import DesafioApps

class UtilsTests: QuickSpec {
    
  override func spec() {
    it("formats a date") {
      let formatter = DateUtils.ISO8601Formatter
      let toFormat = "2017-03-08T14:21:32-0300"
      let formatted = formatter.date(from: toFormat)
      let expectedSecondsFromGMT = -3 * 60 * 60
      let expected = Date(year: 2017, month: 3, day: 8, hour: 14, minutes: 21, seconds: 32, timezoneSecondsFromGMT: expectedSecondsFromGMT)
      expect(expected).toNot(beNil())
      expect(formatted).to(beCloseTo(expected!))
    }
  }
}

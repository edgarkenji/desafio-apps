//
//  ModelTests.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import XCTest
import Nimble
import Quick
import Unbox

@testable import DesafioApps

class ModelTests: QuickSpec {
  
  override func spec() {
    context("models are unboxable") {

      var data:Data!
      beforeEach {
        data = MockData().data
        expect(data).toNot(beNil())
      }
      
      it("unboxes contents from mock file") {
        do {
          let content:[Contents] = try unbox(data: data)
          
          expect(content[0].articles.count).to(equal(14))
          
          let article = content[0].articles[0]
          
          expect(article.id).to(equal(21030945))

        } catch let e {
          fail(e.localizedDescription)
        }
      }
    }
  }
}

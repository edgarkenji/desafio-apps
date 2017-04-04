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
        let path = Bundle(for: type(of: self)).path(forResource: "capa", ofType: "json")
        expect(path).toNot(beNil())

        do {
          let url = URL(fileURLWithPath: path!)
          data = try Data(contentsOf: url)
          expect(data).toNot(beNil())
        } catch let e {
          fail(e.localizedDescription)
        }
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

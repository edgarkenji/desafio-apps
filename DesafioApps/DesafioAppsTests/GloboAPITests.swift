//
//  GloboAPITests.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Moya
import RxSwift
import RxBlocking

@testable import DesafioApps

class GloboAPITests: QuickSpec {
    
  override func spec() {
    
    context("gets cover data from API") {
      it("uses sample data") {
        let provider = MockData().provider
        do {
          let response = try provider.request(.cover).toBlocking().single()
          
          let data = response?.data
          expect(data).toNot(beNil())
          
          try self.parsesAndTestsAPIResponseData(data: data!)
        } catch {
          fail()
        }
      }
      
      it("requests from network") {
        let provider = RxMoyaProvider<GloboAPI>()
        
        do {
          let response = try provider.request(.cover).toBlocking().single()
          
          let data = response?.data
          expect(data).toNot(beNil())
          
          try self.parsesAndTestsAPIResponseData(data: data!)
        } catch {
          fail()
        }
      }
      
      it("requests from service with sample data provider") {
        let provider = MockData().provider
        let service = GloboService(provider: provider)
        do {
          let contents = try service.contents.toBlocking().single()
          expect(contents).toNot(beNil())
          
          expect(contents!.articles.count).to(equal(14))
          
        } catch let e {
          fail(e.localizedDescription)
        }
      }
    }
    
  }
  
  private func parsesAndTestsAPIResponseData(data:Data) throws {
    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]
    let firstItem = json?[0]
    
    expect(firstItem).toNot(beNil())
    
    let content = firstItem!["conteudos"] as? [[String:Any]]
    expect(content).toNot(beNil())
    
    let firstArticle = content!.first
    expect(firstArticle).toNot(beNil())
    
    let id:Int64 = firstArticle!["id"] as! Int64
    expect(id).to(equal(21030945))
  }
}

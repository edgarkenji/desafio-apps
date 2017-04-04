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
        let endpoint = { (target:GloboAPI) -> Endpoint<GloboAPI> in
          let url = target.baseURL.appendingPathComponent(target.path).absoluteString
          return Endpoint<GloboAPI>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
        }
        
        let provider = RxMoyaProvider(endpointClosure: endpoint, stubClosure: MoyaProvider.immediatelyStub)

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

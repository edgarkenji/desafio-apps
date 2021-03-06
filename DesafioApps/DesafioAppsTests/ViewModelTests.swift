//
//  ViewModelTests.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 05/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Unbox
@testable import DesafioApps

class ViewModelTests: QuickSpec {
    
  override func spec() {
    describe("article view model") {
      it("formats article from sample data for viewing") {
        let data = MockData().data
        expect(data).toNot(beNil())
        
        do {
          let content:[Contents] = try unbox(data: data!)
          
          expect(content[0].articles.count).to(equal(14))
          
          let article = content[0].articles[0]
          
          expect(article.id).to(equal(21030945))
          
          let viewModel = ArticleViewModel(article: article)
          expect(viewModel.section).to(match("Brasil".localizedUppercase))
          expect(viewModel.title).to(match("Sérgio Cabral é denunciado pela sexta vez na Lava-Jato"))
          expect(viewModel.imageURL?.absoluteString).to(match("https://ogimg.infoglobo.com.br/in/20620804-669-05e/FT1086A/cabral-preso.jpg"))
          
        } catch let e {
          fail(e.localizedDescription)
        }
      }
    }
    
    describe("home view model using sample data") {
      
      var viewModel:HomeViewModel!
      beforeEach {
        let provider = MockData().provider
        let service = GloboService(provider: provider)
        viewModel = HomeViewModel(service: service)
      }
      
      it("gets cover article") {
        do {
          let cover:Article? = try viewModel.cover.toBlocking().single()
          expect(cover).toNot(beNil())
          expect(cover!.id).to(equal(21030945))
          
          
        } catch let e {
          fail(e.localizedDescription)
        }
      }
      
      it("gets articles except cover article") {
        do {
          let articles:[Article]? = try viewModel.articles.toBlocking().single()
          expect(articles).toNot(beNil())
          expect(articles!.count).to(equal(13)) // doesn't include cover article
          
          expect(articles!.first!.id).to(equal(21030875))
        } catch let e {
          fail(e.localizedDescription)
        }
      }
    }
    
    describe("loading view model") {
      var viewModel:LoadingViewModel!
      beforeEach {
        viewModel = LoadingViewModel()
      }
      
      it("shows loading message") {
        viewModel.setState(.loading)
        
        expect(viewModel.state.value).to(equal(LoadingState.loading))
        expect(viewModel.message).to(match("Carregando, aguarde..."))
        expect(viewModel.isLoading).to(beTrue())
        expect(viewModel.isHidden).to(beFalse())
        expect(viewModel.showRefreshing).to(beFalse())
      }
      
      it("shows empty message") {
        viewModel.setState(.empty)
        
        expect(viewModel.state.value).to(equal(LoadingState.empty))
        expect(viewModel.message).to(match("Nenhum resultado encontrado"))
        expect(viewModel.isLoading).to(beFalse())
        expect(viewModel.isHidden).to(beFalse())
        expect(viewModel.showRefreshing).to(beTrue())
      }
      
      it("shows error message") {
        viewModel.setState(.error)
        
        expect(viewModel.state.value).to(equal(LoadingState.error))
        expect(viewModel.message).to(match("Ocorreu um erro, por favor tente novamente mais tarde"))
        expect(viewModel.isLoading).to(beFalse())
        expect(viewModel.isHidden).to(beFalse())
        expect(viewModel.showRefreshing).to(beTrue())
      }
      
      it("shows no message") {
        viewModel.setState(.loaded)
        
        expect(viewModel.state.value).to(equal(LoadingState.loaded))
        expect(viewModel.message).to(beEmpty())
        expect(viewModel.isLoading).to(beFalse())
        expect(viewModel.isHidden).to(beTrue())
        expect(viewModel.showRefreshing).to(beFalse())
      }
    }
  }
}

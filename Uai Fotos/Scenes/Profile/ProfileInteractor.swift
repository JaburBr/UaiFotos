//
//  ProfileInteractor.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 13/12/2017.
//  Copyright (c) 2017 Uai Fotos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfileBusinessLogic {
  func doSomething(request: Profile.Something.Request)
}

protocol ProfileDataStore {
  //var name: String { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
  var presenter: ProfilePresentationLogic?
  var worker: ProfileWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Profile.Something.Request) {
    worker = ProfileWorker()
    worker?.doSomeWork()
    
    let response = Profile.Something.Response()
    presenter?.presentSomething(response: response)
  }
}

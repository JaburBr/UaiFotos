//
//  ProfileViewController.swift
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

protocol ProfileDisplayLogic: class {
  func displaySomething(viewModel: Profile.Something.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
  var interactor: ProfileBusinessLogic?
  var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = ProfileInteractor()
    let presenter = ProfilePresenter()
    let router = ProfileRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
    }
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething() {
    let request = Profile.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: Profile.Something.ViewModel) {
    //nameTextField.text = viewModel.name
  }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath)
        
        return cell
    }
}

//
//  Coordinator.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit

enum CoordinatorSegue{
    case main
}
class Coordinator{
    
    static let shared = Coordinator()
    let navigationController = UINavigationController()
    
    func initWithWindow(window: UIWindow){
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    func segue(to: CoordinatorSegue){
        switch to {
        case .main:
            break
        }
    }
    func showMain(){
        let vc = configureMainViewController()
        navigationController.viewControllers = [vc]
    }
    
    private func configureMainViewController() -> UIViewController{
        let networkManager = NetworkManager()
        return MainViewController(networkManager: networkManager)
    }
    
}

//
//  MainViewController.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit


class MainViewController: UIViewController{

    var networkManager: NetworkManager!
    var customView: MainView!
    var refreshControl: UIRefreshControl!
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        getNewImages()
    }
    @objc private func getNewImages(){
        networkManager.getNewImages(page: 1) { [weak self] (images, error) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            if let error = error {
                print(error)
            }
            if let images = images {
                DispatchQueue.main.async {
                    self.customView.images = images
                }
            }
        }
    }
    private func setView(){
        customView = MainView(frame: view.frame)
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getNewImages), for: .valueChanged)
        customView.collectionView.refreshControl = refreshControl
        self.view = customView
    }
    
}

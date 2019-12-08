//
//  BaseViewController.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 07/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - Properties
    internal let loaderOverlay: LoaderOverlay = LoaderOverlay.shared

    internal var isScrolling = false
    lazy internal var titleView: ScrollingNavigationBarTitleView = {
        return ScrollingNavigationBarTitleView(isScrolling: isScrolling)
    }()
    
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainViewBackground
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationItem.title == nil{
            navigationItem.titleView = titleView
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = navigationController?.navigationBar{
            let newBounds = CGRect(x: navigationBar.bounds.origin.x + (navigationBar.backItem == nil ? 0:22),
                                   y: navigationBar.bounds.origin.y,
                                   width: navigationBar.bounds.size.width,
                                   height: navigationBar.bounds.size.height)
            titleView.bounds = newBounds
        }
    }
    
}




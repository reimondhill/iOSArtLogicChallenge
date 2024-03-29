//
//  UIViewControllerExtension.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit


extension UIViewController{
    
    //MARK:- Properties
    /// Returns the current trait status 
    var currentTraitStatus:DeviceTraitStatus{ return DeviceTraitStatus.current }
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    
    //MARK:- Public methods
    /// Creates and presents new ConfirmationPopupViewController
    /// - Parameters:
    ///   - title: Title to be displayed
    ///   - message: Message to be displayed
    ///   - sender: The UIViewController that displays will present the ConfirmationPopupViewController
    ///   - completion: Callback when the ConfirmationPopupViewController has been dismissed
    func showAlert(withTitle title:String, message:String, sender:UIViewController, completion:(()->Void)?){
        
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok".localized, comment: ""), style: .default, handler: { (action) in
            completion?()
        }))
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    
    ///Adds a right item with title in the navigation bar and returns the UIButton. Further configuration outside this function.
    /// - Parameters:
    ///   - title: Title to be displayed
    @discardableResult
    func addRightNavigationItem(withTitle title:String?)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.constraintToSuperViewEdges()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.navigationBarText, for: .normal)
        button.titleLabel!.textAlignment = .center
        
        if navigationItem.rightBarButtonItems == nil{
            navigationItem.rightBarButtonItems = []
        }
        navigationItem.rightBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    ///Adds a right item with image in the navigation bar and returns the UIButton. Further configuration outside this function.
    /// - Parameters:
    ///   - image: Image to be displayed
    @discardableResult
    func addRightNavigationItem(withImage image:UIImage)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.navigationBarTint
        
        if navigationItem.rightBarButtonItems == nil{
            navigationItem.rightBarButtonItems = []
        }
        navigationItem.rightBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    ///Adds a left item with title in the navigation bar and returns the UIButton. Further configuration outside this function.
    /// - Parameters:
    ///   - title: Title to be displayed
    @discardableResult
    func addLeftNavigationItem(withTitle title:String?)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.constraintToSuperViewEdges()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.navigationBarText, for: .normal)
        button.titleLabel!.textAlignment = .center
        
        if navigationItem.leftBarButtonItems == nil{
            navigationItem.leftBarButtonItems = []
        }
        navigationItem.leftBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    ///Adds a left item with image in the navigation bar and returns the UIButton. Further configuration outside this function.
    /// - Parameters:
    ///   - image: Image to be displayed
    @discardableResult
    func addLeftNavigationItem(withImage image:UIImage)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.navigationBarTint
        
        if navigationItem.leftBarButtonItems == nil{
            navigationItem.leftBarButtonItems = []
        }
        navigationItem.leftBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    /// Makes a the navigation bar transparent
    func makeTransparentNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navigationBarText]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationBarText]
        navBarAppearance.backgroundColor = UIColor.navigationBarBackground.withAlphaComponent(1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    /// Makes a the navigation bar transparent
    func makeSolidtNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navigationBarText]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationBarText]
        navBarAppearance.backgroundColor = UIColor.navigationBarBackground.withAlphaComponent(1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
}

//
//  AppDelegate.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var shared:AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    var statusView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(logClassName, "Welcome to Artlogic")
        
        setupNavigationBarStyle()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if ProcessInfo.processInfo.arguments.contains("TEST"){
            print(logClassName, "I am testing")
            window?.rootViewController = UINavigationController(rootViewController: ArtworksViewController(apiManager: ApiManager(network: MockNetworkManager())))
        }
        else{
            window?.rootViewController = UINavigationController(rootViewController: ArtworksViewController(apiManager: ApiManager(network: NetworkManager())))
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}
    
}


    extension AppDelegate{
        
        func setupNavigationBarStyle() {
            
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = UIColor.navigationBarBackground
            UINavigationBar.appearance().tintColor = UIColor.navigationBarTint
            UINavigationBar.appearance().shadowImage = UIImage()
            
            let navbarFont = UIFont(name: "Helvetica", size: TextSize.navigationTitle)!
            //let barButtonFont = UIFont(name: "Helvetica", size: TextSize.normal)!
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: navbarFont,
                                                                NSAttributedString.Key.foregroundColor: UIColor.navigationBarText]
            
            UITabBar.appearance().barTintColor = UIColor.navigationBarBackground
            UITabBar.appearance().tintColor = UIColor.navigationBarTint
        }
        
    }


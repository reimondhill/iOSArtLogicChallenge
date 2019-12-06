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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(logClassName, "Welcome to BBC News Ramon")
        
        setupNavigationBarStyle()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
//        if ProcessInfo.processInfo.arguments.contains("TEST"){
//            print(logClassName, "I am testing")
//            #if !DEV
//            window?.rootViewController = UINavigationController(rootViewController: HeadlinesViewController(networkHelper: NetworkHelper(network: MockNetwork())))
//            #endif
//        }
//        else{
//            window?.rootViewController = UINavigationController(rootViewController: HeadlinesViewController(networkHelper: NetworkHelper.shared))
//        }
        
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
                    
            UINavigationBar.appearance().barTintColor = UIColor.navigationBarBackground
            UINavigationBar.appearance().tintColor = UIColor.navigationBarTint
            
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarText]
            
            UINavigationBar.appearance().isTranslucent = false
            
            UITabBar.appearance().barTintColor = UIColor.navigationBarBackground
            UITabBar.appearance().tintColor = UIColor.navigationBarTint
        }
        
    }


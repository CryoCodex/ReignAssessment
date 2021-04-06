//
//  AppDelegate.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let _ = ReachabilityManager.shared
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewFactory.getViewForAppView(view: .list)
        window?.makeKeyAndVisible()
        return true
    }

}


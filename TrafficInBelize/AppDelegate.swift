//
//  AppDelegate.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 17/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.lightRed
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
        //讓ststusbar的字變白色，且要再infoplist中設定View controller-based status bar appearance的value為no
        application.statusBarStyle = .lightContent
        let statusBarView = UIView()
        //讓statusbar的顏色變深紅色
        statusBarView.backgroundColor = UIColor.lightRed
        //將statusbar加入到window中
        window?.addSubview(statusBarView)
        
        window?.addConstraintsWithFormat(format: "V:|[v0(20)]|", views: statusBarView)
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarView)
        return true
    }
}

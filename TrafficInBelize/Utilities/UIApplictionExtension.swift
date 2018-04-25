//
//  UIApplictionExtension.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 17/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension UIApplication{
    static func mainTabBarController() -> MainTabBarController?{
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
    
    static func getWindow() -> UIWindow?{
        return shared.keyWindow
    }
}

//
//  MainTabBarViewController+SetupTabBarDelegate.swift
//  LottieAnimationStartedProject
//
//  Created by 辛忠翰 on 13/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
extension MainTabBarController: SetupTabBarDelegate{
    //MARK:- Setup Functions
    
    
    func setupTabBarController(){
        let example1ViewController = Example1ViewController()
        
        let example1NaviViewController = setupNavigationController(with: example1ViewController, title: "Traffic Signals", image: #imageLiteral(resourceName: "traffic-lights").withRenderingMode(.alwaysOriginal))
        
        let example2ViewController = Example2ViewController()
        let example2NaviViewController = setupNavigationController(with: example2ViewController, title: "Rules", image: nil)
        
        let example3ViewController = Example3ViewController()
        let example3NaviViewController = setupNavigationController(with: example3ViewController, title: "Animation3", image: nil)
        tabBar.tintColor = .red
        viewControllers = [
            example1NaviViewController,
//            example2NaviViewController,
            example3NaviViewController
        ]
    }
    
    //MARK:- Helper Functions
    fileprivate func setupNavigationController(with rootVC: UIViewController, title: String, image: UIImage?) -> UIViewController{
        let naviController = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = title
        
        naviController.tabBarItem.title = title
        naviController.tabBarItem.image = image
        return naviController
    }
}

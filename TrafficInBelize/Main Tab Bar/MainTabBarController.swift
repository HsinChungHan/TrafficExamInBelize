//
//  MainTabBarController.swift
//  LottieAnimationStartedProject
//
//  Created by 辛忠翰 on 13/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
protocol SetupTabBarDelegate {
    func setupTabBarController()
}

class MainTabBarController: UITabBarController {
    
    
    var setupTabBarDelegate: SetupTabBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarDelegate = self
        setupTabBarDelegate?.setupTabBarController()
    }

}

//
//  Example2ViewController.swift
//  LottieAnimationStartedProject
//
//  Created by 辛忠翰 on 13/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
class Example2ViewController: UIViewController {

    var menuOn = false
    var menuButtonAnimationView: LOTAnimationView?
    
    @objc func toggleMenu(recognizer: UITapGestureRecognizer){
        print("toogle")
        menuOn ? setMenuOff() : setMenuOn()
    }
    
    fileprivate func setMenuOn(){
        menuButtonAnimationView?.play { [weak self](_) in
            self?.menuOn = true
            self?.setupMenuButton()
        }
    }
    
    fileprivate func setMenuOff(){
        menuButtonAnimationView?.play { [weak self](_) in
            self?.menuOn = false
            self?.setupMenuButton()
        }
    }
    
    fileprivate func setupMenuButton(){
        if menuButtonAnimationView != nil {
            menuButtonAnimationView?.removeFromSuperview()
            menuButtonAnimationView = nil
        }
        let animationName = menuOn ? "buttonOff" : "buttonOn"
        menuButtonAnimationView = LOTAnimationView(name: animationName)
        guard let menuButtonAnimationView = menuButtonAnimationView else {
            return
        }
        
        menuButtonAnimationView.setupProperties(name: nil, contentMode: .scaleAspectFill, isLoop: false, isUserInteractionEnabled: true)
        menuButtonAnimationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleMenu)))
        view.addSubview(menuButtonAnimationView)
        menuButtonAnimationView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 100, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 100, height: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        
        view.backgroundColor = .white
    }

}

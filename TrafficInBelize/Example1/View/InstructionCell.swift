//
//  InstructionCell.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 19/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
class InstructionCell: BasicCell {
    let animationName = "suspects"
    lazy var trafficLightAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: animationName)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = animationView.animationDuration
        animationView.play(toProgress: 1) { (_) in
        }
        return animationView
    }()
    
    let pinkGreenView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.appleGreen
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Scroll to next!"
        label.textAlignment = .center
        return label
    }()
    
    
    
    override func setupViews() {
        addSubview(pinkGreenView)
        pinkGreenView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 200)
        pinkGreenView.addSubview(titleLabel)
        titleLabel.centerAnchor(superView: pinkGreenView, width: 300, height: 20)
        addSubview(trafficLightAnimationView)
        trafficLightAnimationView.anchor(top: nil, bottom: pinkGreenView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 20, leftPadding: 0, rightPadding: 0, width: 250, height: 250)
        trafficLightAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

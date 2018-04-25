//
//  InstructionCell.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 19/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
protocol InstructionCellDelegate {
    func scrollToNextCell()
}


class InstructionCell: BasicCell {
    let animationName = "suspects"
    var instructionCellDelegate: InstructionCellDelegate?
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
    
    let coverImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "trafficCover")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var pinkGreenView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.appleGreen
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return view
    }()
    
    @objc func handleTap(){
        instructionCellDelegate?.scrollToNextCell()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.text = "Click to start!!"
        label.textAlignment = .center
        return label
    }()
    
    
    
    fileprivate func setupPinkGreenView() {
        addSubview(pinkGreenView)
        pinkGreenView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 200)
        pinkGreenView.addSubview(titleLabel)
        titleLabel.centerAnchor(superView: pinkGreenView, width: 300, height: 50)
        titleLabel.minimizeAnimation(scaleX: 0.8, scaleY: 0.8)
    }
    
    fileprivate func setupCoverImageView() {
        addSubview(coverImageView)
        coverImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coverImageView.anchor(top: topAnchor , bottom: pinkGreenView.topAnchor, left: leftAnchor, right: rightAnchor, topPadding: 30 + 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
    }
    
    override func setupViews() {
        setupPinkGreenView()
        setupCoverImageView()
    }
}

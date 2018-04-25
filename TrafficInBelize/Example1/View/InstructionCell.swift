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
    
    lazy var coverImageView: UIImageView? = {
       let imgView = UIImageView()
        return imgView
    }()
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    
    lazy var pinkGreenView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.appleGreen
        return view
    }()
    
    @objc func handleTap(){
        guard let tapGestureRecognizer = tapGestureRecognizer else {return}
        guard let coverImageView = coverImageView else {
            return
        }
        pinkGreenView.removeGestureRecognizer(tapGestureRecognizer)
        coverImageView.rotateAnimation(angle: 0){[weak self] in
            coverImageView.moveAnimation(dx: coverImageView.frame.width, completion: {
                self?.coverImageView?.removeFromSuperview()
                self?.instructionCellDelegate?.scrollToNextCell()
            })
        }
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
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        guard let tapGestureRecognizer = tapGestureRecognizer else {return}
        pinkGreenView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    fileprivate func setupCoverImageViewProperty(_ coverImageView: UIImageView) {
        coverImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coverImageView.anchor(top: topAnchor , bottom: pinkGreenView.topAnchor, left: leftAnchor, right: rightAnchor, topPadding: 30 + 30, bottomPadding: 30, leftPadding: 30, rightPadding: 30, width: 0, height: 0)
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.layer.shadowOffset = CGSize(width: 5, height: 5 )
        coverImageView.layer.shadowOpacity = 0.7
        coverImageView.layer.shadowRadius = 5
        coverImageView.layer.shadowColor = UIColor.rgb(red: 44, green: 62, blue: 80).cgColor
        let rotationTransform = CGAffineTransform(rotationAngle: -10.0)
        coverImageView.transform = rotationTransform
    }
    
    fileprivate func setupCoverImageView() {
        if coverImageView != nil{
            coverImageView?.removeFromSuperview()
            coverImageView = nil
        }
        coverImageView = UIImageView(image: #imageLiteral(resourceName: "trafficCover"))
        guard let coverImageView = coverImageView else {return}
        addSubview(coverImageView)
        setupCoverImageViewProperty(coverImageView)
        
    }
    
    override func setupViews() {
        setupPinkGreenView()
        setupCoverImageView()
    }
}

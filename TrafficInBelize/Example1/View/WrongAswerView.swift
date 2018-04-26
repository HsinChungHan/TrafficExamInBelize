//
//  WhiteBackgroundView.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 18/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol WrongAnswerDisappearBlackViewDelegate {
    func disappearBlackView()
    func removeColockAnimationView()
}

class WrongAswerView: BasicView {
    var isTimeUp: Bool?{
        didSet{
            guard let isTimeUp = isTimeUp else {return}
            if isTimeUp{
                captionLabel.text =  "Time's up, bro 😰"
            }
        }
    }
    var trafficSign: TrafficSignal?{
        didSet{
           trafficSignView.image = trafficSign?.signImage
            guard let rightAnswer = trafficSign?.rightAnswer else {return}
            answerLabel.text = rightAnswer
        }
    }
    
    var wrongAnswerDisappearBlackViewDelegate: WrongAnswerDisappearBlackViewDelegate?

    let captionLabel: UILabel = {
       let label = UILabel()
        label.text = "You're Wrong 😭"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.darkBlueColor
        label.textAlignment = .center
        return label
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "No-Entry"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.lightRed
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        return label
    }()
    
    let gotItButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Swipe to Continue ⏱", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        btn.backgroundColor = UIColor.appleGreen
        btn.layer.cornerRadius = 5.0
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(handleGotItBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleGotItBtn(){
        handlePan()
    }
    
    let trafficSignView: UIImageView = {
       let imv = UIImageView()
        imv.image = #imageLiteral(resourceName: "img0")
        imv.contentMode = .scaleAspectFill
        return imv
    }()
    
    fileprivate func setupCaptionLabel(){
        addSubview(captionLabel)
        captionLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 55)
    }
    
    fileprivate func setTrafficSignView(){
        addSubview(trafficSignView)
        trafficSignView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 70 + 44, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 250, height: 250)
        trafficSignView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setupAnswerLabel(){
        addSubview(answerLabel)
        answerLabel.anchor(top: trafficSignView.bottomAnchor, bottom: nil, left: captionLabel.leftAnchor, right: rightAnchor, topPadding: 30, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 55)
        answerLabel.minimizeAnimation(scaleX: 0.8, scaleY: 0.8)
    }
    
    fileprivate func setupGotItBtn(){
        addSubview(gotItButton)
        gotItButton.anchor(top: answerLabel.bottomAnchor, bottom: nil, left: answerLabel.leftAnchor, right: answerLabel.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 55)
//        gotItButton.minimizeAnimation(scaleX: 0.8, scaleY: 0.8)
    }
    
    fileprivate func setupGestures(){
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc func handlePan(){
        wrongAnswerDisappearBlackViewDelegate?.removeColockAnimationView()
        let rotateTransform = CGAffineTransform(rotationAngle: 180)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [
            .curveEaseInOut], animations: { [weak self] in
            self?.transform = rotateTransform
            self?.alpha = 0.0
            self?.wrongAnswerDisappearBlackViewDelegate?.disappearBlackView()
        })
    }
    
    override func setupViews() {
        backgroundColor = .white
        setupCaptionLabel()
        setTrafficSignView()
        setupAnswerLabel()
        setupGestures()
        setupGotItBtn()
    }
}


//
//  Example1Cell.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 18/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
import GameKit
protocol Example1CellDelegate {
    func scrollToNextIndex(indexPath: IndexPath)
}

protocol GetRandomNumberDelegate {
    func getRandomNumber() -> [Int]
}

enum AnimationViewName: String{
    case correct = "checked_done"
    case wrong = "empty_status"
    case walking = "cycle_animation"
    case timer = "timer_rory"
    case crying = "crying"
    case star = "star"
    case timeUp = "emoji_shock"
}


class Example1Cell:  BasicCell{
    var user: BelizeUser? {
        didSet{
            guard let user = user else {
                return
            }
            self.correctLabel.text = "\(user.correct)"
            self.wrongLabel.text = "\(user.wrong)"
        }
    }
    var trafficSign: TrafficSignal?{
        didSet{
            guard let trafficSign = trafficSign else {
                return
            }
            trafficImageView.image = trafficSign.signImage
            let allAnswers = [trafficSign.wrongAnswer1, trafficSign.wrongAnswer2, trafficSign.rightAnswer]
//            answerButtonZero.setTitle(trafficSign?.wrongAnswer1, for: .normal)
//            answerButtonOne.setTitle(trafficSign?.wrongAnswer2, for: .normal)
//            answerButtonTwo.setTitle(trafficSign?.rightAnswer, for: .normal)
            randomSetTitle(allAnsers: allAnswers)
        }
    }
    
    var getRandomNumberDelegate: GetRandomNumberDelegate?
    
    fileprivate func randomSetTitle(allAnsers: [String]){
        var allAnsers = allAnsers
        getRandomNumberDelegate = self
        guard let randomNums = getRandomNumberDelegate?.getRandomNumber() else {return}
        let allButtons = [answerButtonZero, answerButtonOne, answerButtonTwo]
        for index in randomNums {
            allButtons.forEach { (btn) in
                if btn.tag == index{
                    btn.setTitle(allAnsers[0], for: .normal)
                    allAnsers.removeFirst()
                }
            }
        }
        
    }
    
    var walkingIndexPath: IndexPath?{
        didSet{
            guard let index = walkingIndexPath?.item else {return}
            let viewWidth = frame.width
            let leftPadding = 10 + (viewWidth - 20)/7 * CGFloat(index)
            setupWalkingAnimationView(leftPadding: leftPadding)
        }
    }
    
    var example1CellDelegate: Example1CellDelegate?
    var limitedTime: Int?{
        didSet{
            guard let limitedTime = limitedTime else {return}
            self.timeLabel.text = String(limitedTime)
        }
    }
    
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightRed
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var checkAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = false
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    lazy var clockAnimationView: LOTAnimationView? = {
        let animationView = LOTAnimationView()
        return animationView
    }()
    
    lazy var walkingAnimationView: LOTAnimationView? = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: AnimationViewName.walking.rawValue)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 1
        return animationView
    }()
    
    let trafficImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "img0")
        return iv
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Please select the correct traffic signal"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    lazy var answerButtonZero: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 0
        btn.backgroundColor = UIColor.appleGreen
        btn.setTitle("No-Entry", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleAnswerBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var answerButtonOne: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 1
        btn.backgroundColor = UIColor.appleGreen
        btn.setTitle("Yes-Entry", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleAnswerBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var answerButtonTwo: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 2
        btn.backgroundColor = UIColor.appleGreen
        btn.setTitle("Stop", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleAnswerBtn), for: .touchUpInside)
        return btn
    }()
    
    let blackView = UIView()
    
    @objc func handleAnswerBtn(sender: UIButton){
        walkingAnimationView?.removeFromSuperview()
        walkingAnimationView = nil
        clockAnimationView?.pause()
        clockAnimationView?.removeFromSuperview()
        guard let window = UIApplication.getWindow() else {return}
        setupBlackView(window: window, blackView: blackView, checkAnimationView: checkAnimationView, sender: sender)
        
    }
    
    func resetPoints(){
        wrongLabel.text = "0"
        correctLabel.text = "0"
    }
    
    lazy var correctAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: AnimationViewName.star.rawValue)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = false
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    let correctImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "thumb")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let correctLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightRed
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var wrongAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: AnimationViewName.crying.rawValue)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightRed
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    func setupClockAnimationView() {
        if clockAnimationView != nil{
            clockAnimationView?.removeFromSuperview()
            clockAnimationView = nil
        }
        clockAnimationView = LOTAnimationView(name: AnimationViewName.timer.rawValue)
        guard let clockAnimationView = clockAnimationView else {return}
        addSubview(clockAnimationView)
        clockAnimationView.contentMode = .scaleAspectFill
        clockAnimationView.loopAnimation = false
        clockAnimationView.animationSpeed = clockAnimationView.animationDuration/6
        clockAnimationView.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, topPadding: 30, bottomPadding: 0, leftPadding: 0, rightPadding: 10, width: 80, height: 80)
        
    }
    
    func setupWalkingAnimationView(leftPadding: CGFloat) {
        if walkingAnimationView != nil{
            walkingAnimationView?.removeFromSuperview()
            walkingAnimationView = nil
        }
        walkingAnimationView = LOTAnimationView(name: AnimationViewName.walking.rawValue)
        guard let walkingAnimationView = walkingAnimationView else {return}
        addSubview(walkingAnimationView)
        walkingAnimationView.contentMode = .scaleAspectFill
        walkingAnimationView.loopAnimation = true
        walkingAnimationView.animationSpeed = 1
        walkingAnimationView.play()
        walkingAnimationView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 60, leftPadding: 0, rightPadding: 0, width: 60, height: 60)
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            let transform = CGAffineTransform(translationX: leftPadding, y: 0)
            walkingAnimationView.transform = transform
        }) { (_) in
            
        }
    }
    
    
    func setupTrafficSignView() {
        addSubview(trafficImageView)
        trafficImageView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 80, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 200, height: 200)
        trafficImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupTitleLabel(){
        addSubview(titleLabel)
        titleLabel.anchor(top: trafficImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 15, bottomPadding: 0, leftPadding: 15, rightPadding: 15, width: 0, height: 45)
        
    }
    
    
    func setupButton() {
        addSubview(answerButtonZero)
        addSubview(answerButtonOne)
        addSubview(answerButtonTwo)
        answerButtonZero.anchor(top: titleLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 30, rightPadding: 30, width: 0, height: 50)
        answerButtonOne.anchor(top: answerButtonZero.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 30, rightPadding: 30, width: 0, height: 50)
        answerButtonTwo.anchor(top: answerButtonOne.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 30, rightPadding: 30, width: 0, height: 50)
        answerButtonZero.layer.cornerRadius = 25
        answerButtonZero.clipsToBounds = true
        answerButtonOne.layer.cornerRadius = 25
        answerButtonOne.clipsToBounds = true
        answerButtonTwo.layer.cornerRadius = 25
        answerButtonTwo.clipsToBounds = true
    }
    
    func setupCorrectAnimationView() {
        addSubview(correctImageView)
        correctImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 25, bottomPadding: 0, leftPadding: 15, rightPadding: 0, width: 50, height: 50)
        addSubview(correctLabel)
        correctLabel.anchor(top: nil, bottom: nil, left: correctImageView.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 20, height: 50)
        correctLabel.centerYAnchor.constraint(equalTo: correctImageView.centerYAnchor).isActive = true
    }
    
    func setupWrongAnimationView() {
        addSubview(wrongAnimationView)
        wrongAnimationView.anchor(top: correctImageView.bottomAnchor, bottom: nil, left: correctImageView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 50, height: 50)
        wrongAnimationView.play()
        addSubview(wrongLabel)
        wrongLabel.anchor(top: nil, bottom: nil, left: wrongAnimationView.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 20, height: 50)
        wrongLabel.centerYAnchor.constraint(equalTo: wrongAnimationView.centerYAnchor).isActive = true
        
    }
    
    override func setupViews() {
        setupTrafficSignView()
        setupTitleLabel()
        setupButton()
        setupCorrectAnimationView()
        setupWrongAnimationView()
        
    }
}














extension Example1Cell{
    fileprivate func addBlackView(_ window: UIWindow, _ blackView: UIView) {
        window.addSubview(blackView)
        blackView.backgroundColor = UIColor.lightBlackColor
        blackView.frame = window.frame
        blackView.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
        }, completion: nil)
    }
    
    fileprivate func setupBlackView(window: UIWindow, blackView: UIView, checkAnimationView: LOTAnimationView, sender: UIButton){
        addBlackView(window, blackView)
        window.addSubview(checkAnimationView)
        checkAnimationView.centerAnchor(superView: window, width: 250, height: 250)
        if isCorrect(sender: sender){
            checkAnimationView.setAnimation(named: AnimationViewName.correct.rawValue)
            checkAnimationView.play(toProgress: 1.0) {[weak self] (_) in
                self?.checkAnimationView.removeFromSuperview()
                self?.disappearBlackView()
            }
            guard let user = user else {return}
            user.correct += 1
        }else{
            checkAnimationView.setAnimation(named: AnimationViewName.wrong.rawValue)
            checkAnimationView.play(toProgress: 0.3) {[weak self] (_) in
                self?.checkAnimationView.removeFromSuperview()
                guard let blackView = self?.blackView else {return}
                self?.setWrongBackgroundView(blackView: blackView, isTimeUp: false)
            }
            
            guard let user = user else {return}
            user.wrong += 1
        }
    }
    
    fileprivate func isCorrect(sender: UIButton) -> Bool{
        if sender.titleLabel?.text == trafficSign?.rightAnswer{
            return true
        }
        return false
    }
    
    fileprivate func setWrongBackgroundView(blackView: UIView, isTimeUp: Bool){
        let wrongView = WrongAswerView()
        wrongView.isTimeUp = isTimeUp
        wrongView.trafficSign = trafficSign
        wrongView.wrongAnswerDisappearBlackViewDelegate = self
        blackView.addSubview(wrongView)
        wrongView.anchor(top: blackView.topAnchor, bottom: nil, left: blackView.leftAnchor, right: blackView.rightAnchor, topPadding: 120, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 650)
        wrongView.layer.cornerRadius = 10.0
        wrongView.clipsToBounds = true
    }
    
    func timeUpView(){
        guard let user = user else {return}
        user.wrong += 1
        guard let window = UIApplication.getWindow() else {return}
        addBlackView(window, blackView)
        window.addSubview(checkAnimationView)
        checkAnimationView.centerAnchor(superView: window, width: 250, height: 250)
        checkAnimationView.setAnimation(named: AnimationViewName.timeUp.rawValue)
        checkAnimationView.play(toProgress: 0.7) { [weak self] (_) in
            self?.checkAnimationView.removeFromSuperview()
            guard let blackView = self?.blackView else {return}
            self?.setWrongBackgroundView(blackView: blackView, isTimeUp: true)
        }
    }
    
}




extension Example1Cell: GetRandomNumberDelegate{
    func getRandomNumber() -> [Int]{
        var numbers = [Int]()
        let shuffledDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: 2)
        for _ in 0..<3 {
            let index  = shuffledDistribution.nextInt()
            numbers.append(index)
        }
        return numbers
    }
    
    
}

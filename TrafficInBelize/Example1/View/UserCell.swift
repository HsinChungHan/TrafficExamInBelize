//
//  UserCell.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 23/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Charts
enum Comment: String{
    case wellDone = "Well done, you finish all questions 😃"
    case cheerUp = "Cheer up 😱"
}


protocol UserCellDelegate {
    func scrollToStart()
}

class UserCell: BasicCell {
    var userCellDelegate: UserCellDelegate?
    var scoreDataEntry: ScoreDataEntry?
    var comment: String?{
        didSet{
            guard let comment = comment else {return}
            commentLabel.text = comment
        }
    }
    
    var user: BelizeUser?{
        didSet{
            guard let user = user else {return}
            setupDataEntryProperties(user: user)
            givingComment(user: user)
        }
    }
    
    let commentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = UIColor.lightRed
        label.textAlignment = .center
        return label
    }()
    
    lazy var pieChartView: PieChartView = {
       let pcv = PieChartView()
        pcv.chartDescription?.text = "Score"
       return pcv
    }()
    
    
    lazy var scrollToStartAndResetUserButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.setTitle("Back to start page", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.appleGreen
        btn.addTarget(self, action: #selector(handleScrollToStartBtn), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleScrollToStartBtn(){
        guard let user = user else {return}
        submitScores(user: user)
        user.resetUser()
        userCellDelegate?.scrollToStart()
    }
    
    fileprivate func submitScores(user: BelizeUser){
        let values = [
            "correct_counts" : user.correct,
            "wrong_counts" : user.wrong,
            "creationDate" : Date().timeIntervalSince1970
            ] as [String : Any]
        let dbRef = Database.database().reference().child("scores").childByAutoId()
        dbRef.updateChildValues(values) { (error, reference) in
            if let err = error{
                print("Failed to update grades into DB: ", err)
                return
            }
            print("Successfully to update comment into DB!")
            print(reference)
        }
        
    }
    
    func setupScrollToStartButton(){
        addSubview(scrollToStartAndResetUserButton)
        scrollToStartAndResetUserButton.anchor(top: nil, bottom: bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 60, leftPadding: 0, rightPadding: 0, width: 300, height: 50)
        scrollToStartAndResetUserButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollToStartAndResetUserButton.layer.cornerRadius = 25
        scrollToStartAndResetUserButton.clipsToBounds = true
    }
    
    fileprivate func givingComment(user: BelizeUser){
        if user.correct >= user.wrong{
            comment = Comment.wellDone.rawValue
        }else{
            comment = Comment.cheerUp.rawValue
        }
    }
    
    fileprivate func setupDataEntryProperties(user: BelizeUser){
        scoreDataEntry = ScoreDataEntry.init(correctNum: Double(user.correct), wrongNum: Double(user.wrong))
        guard let scoreDataEntry = scoreDataEntry else {return}
        scoreDataEntry.correctDataEntry.label = "Correct"
        scoreDataEntry.wrongDataEntry.label = "Incorrect"
        updateChartData()
        pieChartView.alpha = 0.0
        commentLabel.alpha = 0.0
        UIView.animate(withDuration: 3.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {[weak self] in
            self?.pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            self?.commentLabel.alpha = 1.0
            self?.pieChartView.alpha = 1.0
        }) { (_) in
            
        }
    }
    
    fileprivate func setupPieChartView(){
        addSubview(pieChartView)
        pieChartView.centerAnchor(superView: self, width: 500, height: 500)
    }
    
    
    fileprivate func updateChartData(){
        guard let scoreDataEntry = scoreDataEntry else {return}
        let chartDataSet = PieChartDataSet(values: scoreDataEntry.dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [UIColor(named: "correctColor"), UIColor(named: "wrongColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        pieChartView.data = chartData
    }
    
    fileprivate func setupCommentLabel(){
        addSubview(commentLabel)
        commentLabel.anchor(top: nil, bottom: pieChartView.topAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 20, leftPadding: 20, rightPadding: 20, width: 0, height: 40)
    }
    
    override func setupViews() {
        setupPieChartView()
        setupScrollToStartButton()
        setupCommentLabel()
        
    }
}

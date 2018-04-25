//
//  Example1VC+UICOllectionViewDelegate.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 20/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import  Lottie
extension Example1ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    //發現這邊的index超不準，會亂跳
    //所以手指拖拉滑動的話要用scrollViewWillEndDragging，用座標計算出真實的index，然後再根據賦timer給cell
    //程式滑動(scrollToItem(atIndex))，可精準算出index再賦值
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.instructionCellID.rawValue, for: indexPath) as! InstructionCell
            collectionView.isScrollEnabled = true
            return cell
        }else if indexPath.item < 7{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.example1CellID.rawValue, for: indexPath) as! Example1Cell
            cell.trafficSign = trafficSigns[indexPath.item - 1]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.userCellID.rawValue, for: indexPath) as! UserCell
            cell.userCellDelegate = self
            return cell
        }
    }
    
    
    
    //當cell滑動時會被觸發(程式或手指拖拉都會移動)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.x可以找出每次cell的位移
        //        menuBar.horiziontalBarViewLeftAncor?.constant = scrollView.contentOffset.x / 4
    }
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //可以找到每個cell最左上方的點的位置
        //換言之可以得到每個cell的起始位置
        //當滑動cell時觸發(只有用手指拖拉時才會移動)
        let cellIndex = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(cellIndex), section: 0)
        collectionView.isScrollEnabled = false
        guard let cell = collectionView.cellForItem(at: indexPath) as? Example1Cell else {return}
        cell.setupClockAnimationView()
        cell.layoutIfNeeded()
        guard let clockAnimationiew = cell.clockAnimationView else {return}
        didAnimationViewFinish(view: clockAnimationiew, completion: {
            cell.timeUpView()
        })
        cell.example1CellDelegate = self
        cell.user = user
        cell.walkingIndexPath = indexPath
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //程式自動滾動後會觸發此function
        guard let currentIndexPath = currentIndexpath else {return}
        if let cell = collectionView.cellForItem(at: currentIndexPath) as? Example1Cell {
            cell.setupClockAnimationView()
            cell.layoutIfNeeded()
            guard let clockAnimationiew = cell.clockAnimationView else {return}
            print("ClockAnimationView: ", clockAnimationiew.animationProgress)
            didAnimationViewFinish(view: clockAnimationiew, completion: {
                cell.timeUpView()
            })
            cell.example1CellDelegate = self
            cell.user = user
            cell.walkingIndexPath = currentIndexPath
        }else if let cell = collectionView.cellForItem(at: currentIndexPath) as? UserCell{
            cell.user = user
        }
        
    }
    
}

extension Example1ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension Example1ViewController{
    func didAnimationViewFinish(view: LOTAnimationView, completion: @escaping ()->()) {
        view.play(toProgress: 1.0) { (completed) in
            if completed{
                completion()
            }
        }
    }
}

extension Example1ViewController: UserCellDelegate{
    func scrollToStart() {
        let startIndexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: startIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}

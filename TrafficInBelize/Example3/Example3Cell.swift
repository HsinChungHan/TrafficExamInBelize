
//
//  Example3Cell.swift
//  LottieAnimation
//
//  Created by 辛忠翰 on 12/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class Example3Cell: UICollectionViewCell {
    var labelText: String? {
        didSet{
            titleLabel.text = labelText
        }
    }
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    func setupView() {
        backgroundColor = UIColor.appleGreen
        addSubview(titleLabel)
        titleLabel.centerAnchor(superView: self, width: 250, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

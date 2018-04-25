//
//  TrafficSignalModel.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 20/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
struct TrafficSignal {
    var signImage: UIImage
    var rightAnswer: String
    var wrongAnswer1: String
    var wrongAnswer2: String
    static func getTrafficSigns() -> [TrafficSignal] {
        return [
            TrafficSignal(signImage: #imageLiteral(resourceName: "img0"), rightAnswer: "No-Entry", wrongAnswer1: "Entry", wrongAnswer2: "Stop"),
            TrafficSignal(signImage: #imageLiteral(resourceName: "img1"), rightAnswer: "No-Parking", wrongAnswer1: "Parking", wrongAnswer2: "No-Sleeping"),
            TrafficSignal(signImage: #imageLiteral(resourceName: "img2"), rightAnswer: "Stop", wrongAnswer1: "Nonstop", wrongAnswer2: "Keep Going"),
            TrafficSignal(signImage: #imageLiteral(resourceName: "img3"), rightAnswer: "Two-Way", wrongAnswer1: "One-Way", wrongAnswer2: "No-Way"),
            TrafficSignal(signImage: #imageLiteral(resourceName: "img4"), rightAnswer: "N0-U-Turn", wrongAnswer1: "U-Turn", wrongAnswer2: "Y-Turn"),
            TrafficSignal(signImage: #imageLiteral(resourceName: "img5"), rightAnswer: "Wide-to-Narrow", wrongAnswer1: "Narrow-to-Wide", wrongAnswer2: "Narrow-to-Narrow")
        ]
    }
}


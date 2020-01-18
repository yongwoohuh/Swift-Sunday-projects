//
//  Int-TimeFormatting.swift
//  02_FriendZone
//
//  Created by Yongwoo Huh on 2020/01/18.
//  Copyright © 2020 Yongwoo Huh. All rights reserved.
//

import Foundation

extension Int {
    func timeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(self)) ?? "0"
        
        if formattedString == "0" {
            return "GMT"
        } else {
            if formattedString.hasPrefix("-") {
                return "GMT\(formattedString)"
            } else {
                return "GMT+\(formattedString)"
            }
        }
    }
    
}

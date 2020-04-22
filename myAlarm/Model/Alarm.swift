//
//  Alarm.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class Alarm: Codable {
    var name: String
    var enabled: Bool
    var uuid: String
    var fireDate: Date
    var fireTimeAsString: String {
        let formatter3 = DateFormatter()
        formatter3.timeStyle = .short
        formatter3.dateFormat = .none
        return formatter3.string(from: fireDate)
    }
    
    init(name: String, enabled: Bool, uuid: String = UUID().uuidString, fireDate: Date ) {
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        self.fireDate = fireDate
    }
    
} /// Eoc

extension Alarm: Equatable {
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}





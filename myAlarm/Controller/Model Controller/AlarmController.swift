//
//  AlarmController.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    //var alarms: [Alarm] = [Alarm]()
    
    var alarms: [Alarm] = {
        let alarm1 = Alarm(name: "Alarm1", enabled: false, fireDate: Date())
        let alarm2 = Alarm(name: "Alarm2", enabled: true, fireDate: Date())
        return [alarm1, alarm2]
    }()
    
    func alarmEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    // CRUD
    func create(name: String, enabled: Bool, fireDate: Date) -> Alarm {
        let alarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarms.append(alarm)
        return alarm
    }
    
    // MARK: Update
    func update(alarm: Alarm, name: String, enabled: Bool, fireDate: Date) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms[index].name = name
        alarms[index].enabled = enabled
    }
    
    // Delete
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
}

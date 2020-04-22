//
//  AlarmController.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

protocol ScheduleLocalNotificationDelegate: class {
    
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

class AlarmController {
    
    static let sharedInstance = AlarmController()
    fileprivate var jsonFileName: String = "notes.json"
    fileprivate var userNotificationIdentifier: String = "TimerCompletedNotification"

    var alarms: [Alarm] = [Alarm]()
    
    
    func alarmEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    // CRUD
    func create(name: String, enabled: Bool, fireDate: Date) {
        let alarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarms.append(alarm)
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    // MARK: Update
    func update(alarm: Alarm, name: String, enabled: Bool, fireDate: Date) {
        cancelUserNotifications(for: alarm)
        alarm.name = name
        alarm.enabled = enabled
        alarm.fireDate = fireDate
        scheduleUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        cancelUserNotifications(for: alarm)
        alarms.remove(at: index)
        saveToPersistentStore()
    }
    
    
    //MARK: JSON Persistance
    func createJsonFilePersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(url)
        return url[0].appendingPathComponent(jsonFileName)
    }
    
    func saveToPersistentStore() {
        let je = JSONEncoder()
        
        do {
            let jsonEntry = try je.encode(self.alarms)
            try jsonEntry.write(to: createJsonFilePersistenceStore())
        } catch let e {
            print("Encoding Error \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jd = JSONDecoder()
        
        do {
            let decodeData = try Data(contentsOf: createJsonFilePersistenceStore())
            self.alarms = try jd.decode([Alarm].self, from: decodeData)
        } catch let e {
            print("Decoding Error \(e.localizedDescription)")
        }
    }
    
}

extension AlarmController: ScheduleLocalNotificationDelegate {
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Wake Up!"
        notificationContent.subtitle = "Your personal Alarm says get up!!!"
        notificationContent.badge = 1
        notificationContent.sound = .default()
        
        // Schedule notification
        print("fireDate: \(alarm.fireDate)")
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
         
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        print("UUID: \(alarm.uuid)")
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (inerror) in
            if let error = inerror {
                print(error.localizedDescription)
            }
        }
    }
}




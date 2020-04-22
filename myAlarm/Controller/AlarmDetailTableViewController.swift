//
//  AlaramDetailTableViewController.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var alarmTitleOutlet: UITextField!
    @IBOutlet weak var disableButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        guard let alarm = alarm else { return }
        alarmTitleOutlet.text = alarm.name
        datePickerOutlet.date = alarm.fireDate  //setDate(_ date: Date, animated: true)
        disableButtonOutlet.isEnabled = alarm.enabled
        if alarm.enabled {
            print("Enable button)")
            disableButtonOutlet.setTitle("Enable Alarm",for: .normal)
            //disableButtonOutlet.backgroundColor = .red
        } else {
            print("Disable button")
            disableButtonOutlet.setTitle("Disabled Alarm",for: .normal)
            //disableButtonOutlet.backgroundColor = .gray
        }
        
        // Console Debugging info
        print(alarm.name)
        print(alarm.enabled)
        print(alarm.uuid)
        print(alarm.fireDate)
        print(alarm.fireTimeAsString)
    }
    
    
    // MARK: Action
    @IBAction func enableButtonTappedAction(_ sender: UIButton) {
        print("Toggle")
        guard let theAlarm = alarm else {return}
        AlarmController.sharedInstance.alarmEnabled(for: theAlarm)
        if theAlarm.enabled {
            print("Enabled button")
            disableButtonOutlet.setTitle("Enable Alarm", for: .normal)
            //disableButtonOutlet.backgroundColor = .red
        } else {
            print("Disable button")
            disableButtonOutlet.setTitle("Disabled Alarm ", for: .normal)
            //disableButtonOutlet.backgroundColor = .gray
        }
    }
    
    @IBAction func saveButtonTappedAction(_ sender: UIBarButtonItem) {
    
        if alarm != nil {
            let datePicker = datePickerOutlet.date
            let enabled = disableButtonOutlet.isEnabled
            guard let theName = alarmTitleOutlet.text else { return }
            guard let theAlarm = alarm else {return}
            AlarmController.sharedInstance.update(alarm: theAlarm, name: theName, enabled: enabled, fireDate: datePicker)
            print("Updated alarm")
        } else {
            let datePicker = datePickerOutlet.date
            let enabled = disableButtonOutlet.isEnabled
            guard let theName = alarmTitleOutlet.text else { return }
            AlarmController.sharedInstance.create(name: theName, enabled: enabled, fireDate: datePicker)
            print("New alarm")
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}



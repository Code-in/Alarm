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
            // loadViewsIfNeeded()  //*note: It is safest to call loadViewsIfNeeded() in any didSet before updateViews() to avoid any race conditions.
            guard let theAlarm = alarm else { return }
            updateViews(with: theAlarm)
        }
    }
    
    var alarmIsOn: Bool = true
    
    // MARK: Outlets

    //@IBOutlet weak var datePickerOutlet: UIDatePicker!
    //@IBOutlet weak var alarmTitleOutlet: UITextField!
    //@IBOutlet weak var disableButtonOutlet: UIButton!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var alarmTitleOutlet: UITextField!
    @IBOutlet weak var disableButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let theAlarm = alarm else { return }
        updateViews(with: theAlarm)
    }
    
    private func updateViews(with alarm: Alarm) {
        guard self.isViewLoaded else { return }
        alarmTitleOutlet.text = alarm.name
        datePickerOutlet.date = alarm.fireDate  //setDate(_ date: Date, animated: true)
        disableButtonOutlet.isEnabled = alarm.enabled
        if alarm.enabled {
            print("Enable button)")
            disableButtonOutlet.setTitle("On",for: .normal)
            
        } else {
            print("Disable button)")
            disableButtonOutlet.setTitle("Off",for: .disabled)
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
    }
    
    @IBAction func saveButtonTappedAction(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}



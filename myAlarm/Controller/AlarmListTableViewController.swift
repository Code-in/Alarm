//
//  AlarmListTableViewController.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    fileprivate var segueIdentifier: String = "alarmSegue"
    fileprivate var cellIdentifier: String = "alarmCell"
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Lifecycle functions
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.sharedInstance.loadFromPersistentStore()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }

        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        cell.updateViews(with: alarm)
        /// This is STEP 3
        //cell.delegate = self
    
        return cell
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Override to support editing the table view.
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if self.tableView.isEditing == true {
            return .none  // Allows us to edit order of cell items
        } else {
            return .delete // Allows us to delete cell items
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //updateView()
    }
    
    
    // MARK: - Navigation Segue to Details Screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let indexPath = tableView.indexPathForSelectedRow, let dstVC = segue.destination as? AlarmDetailTableViewController else { return }
            print("\(AlarmController.sharedInstance.alarms.count)")
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            dstVC.alarm = alarm
            dstVC.title = alarm.name
        }
    }

} // EoF


extension AlarmListTableViewController: SwitchCellDelegate {
    func switchValueChangedAction(for cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.alarmEnabled(for: alarm)  // What should we use sharedInstance or static fucn alarmEnabled
        cell.updateViews(with: alarm)
    }
} // EoF

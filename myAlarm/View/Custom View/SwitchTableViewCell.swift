//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Pete Parks on 4/20/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

/// STEP 1: declaring the protocol
protocol SwitchCellDelegate: class {
    func switchValueChangedAction(for cell: SwitchTableViewCell)
}


class SwitchTableViewCell: UITableViewCell {
    
    var alarm: Alarm? {
        didSet {
            // loadViewsIfNeeded()  //*note: It is safest to call loadViewsIfNeeded() in any didSet before updateViews() to avoid any race conditions.
            guard let theAlarm = alarm else { return }
            updateViews(with: theAlarm)
        }
    }
    
    /// STEP 2: Create the delegate
    weak var delegate: SwitchCellDelegate?

    // MARK: Outlet
    @IBOutlet weak var timeLabelOutelt: UILabel!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var alarmSwitchOutlet: UISwitch!
    
    
    // MARK: Action
    @IBAction func switchValueChangedAction(_ sender: UISwitch) {
        delegate?.switchValueChangedAction(for: self)
    }
    
    
    // MARK: Methods
    func updateViews(with alarm: Alarm) {
        timeLabelOutelt.text = alarm.fireTimeAsString
        nameLabelOutlet.text = alarm.name
        alarmSwitchOutlet.isOn = alarm.enabled
        self.backgroundColor = alarm.enabled ? .cyan : .white
    }
    
} // EoC

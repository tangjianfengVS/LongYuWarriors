//
//  LYWarriorsBluetoothCell.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/27.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import CoreBluetooth

class LYWarriorsBluetoothCell: UITableViewCell {
    @IBOutlet weak var identifierLab: UILabel!
    //@IBOutlet weak var historyLab: UILabel!
    @IBOutlet weak var deviceLab: UILabel!
    @IBOutlet weak var startsLab: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var conentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    //<CBPeripheral: 0x1027cdd30, identifier = 47539569-CE0C-E60D-8850-3E680A48E1E6, name = (null), state = disconnected>
    var lyPeripheral: LYWarriorsBCBPeripheral?{
        didSet{
            let name = lyPeripheral!.peripheral.name ?? lyPeripheral!.peripheral.identifier.uuidString
            identifierLab.text = name
            //deviceLab.text = "ssss"
            startsLab.text = lyPeripheral!.RSSI.stringValue
            
            if lyPeripheral!.isConnect {
                conentLab.isHidden = false
                activityIndicatorView.isHidden = false
                activityIndicatorView.startAnimating()
            }else{
                conentLab.isHidden = true
                activityIndicatorView.isHidden = true
                activityIndicatorView.stopAnimating()
            }
        }
    }
}

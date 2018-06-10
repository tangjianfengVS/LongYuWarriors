//
//  LYWarriorsBCBPeripheral.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/27.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import CoreBluetooth

class LYWarriorsBCBPeripheral: NSObject {
    private(set) var peripheral: CBPeripheral!
    private(set) var RSSI: NSNumber!
    private(set) var advertisementData: [String : Any]?
    var isConnect: Bool=false

    init(peripherals: CBPeripheral, rssi: NSNumber, data: [String:Any]?) {
        peripheral = peripherals
        RSSI = rssi
        advertisementData = data
    }
}

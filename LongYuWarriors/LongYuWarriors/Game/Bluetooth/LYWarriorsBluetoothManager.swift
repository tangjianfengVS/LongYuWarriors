//
//  LYWarriorsBluetoothManager.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/27.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import CoreBluetooth

class LYWarriorsBluetoothManager: NSObject{
    fileprivate(set) var peripheralArray: [LYWarriorsBCBPeripheral] = []
    private var central: CBCentralManager?
    private var peripheralConnect: LYWarriorsBCBPeripheral?
    private var writeCharacteristic: CBCharacteristic!
    
    var myClouse: ((Bool)->())?
    var connectClouse: (()->())?
    
    override init() {
        super.init()
        central = CBCentralManager(delegate: self, queue: nil)
    }
    
    func connect(indexPath: IndexPath ,clouse: @escaping (()->())) {
        let lyPeripheral = peripheralArray[indexPath.row]
        if peripheralConnect != nil && peripheralConnect == lyPeripheral{
            return
        }else if peripheralConnect != nil {
            peripheralConnect?.isConnect = false
            peripheralConnect = nil
        }
        
        lyPeripheral.isConnect = true
        peripheralConnect = lyPeripheral
        clouse()
        connectClouse = clouse
        central!.connect(lyPeripheral.peripheral, options: nil)
    }
}

extension LYWarriorsBluetoothManager: CBCentralManagerDelegate, CBPeripheralDelegate{
    //检查支持BLE
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        switch central.state {
        case .poweredOn:
            //写nil表示扫描所有蓝牙外设，如果传上面的kServiceUUID,那么只能扫描出FFEO这个服务的外设。
            central.scanForPeripherals(withServices: nil, options: nil)
            print("蓝牙已打开,请扫描外设")
        case .unauthorized:
            print("这个应用程序是无权使用蓝牙低功耗")
        case .poweredOff:
            print("蓝牙目前已关闭")
        default:
            print("中央管理器没有改变状态")
        }
    }
    
    //外设的蓝牙信息强度
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("扫描----ing")
        print(peripheral)
        let lyPeripheral = LYWarriorsBCBPeripheral(peripherals: peripheral, rssi: RSSI, data: advertisementData)
        if !peripheralArray.contains(lyPeripheral) {
            peripheralArray.append(lyPeripheral)
            if myClouse != nil{
                myClouse!(true)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        central.stopScan()
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    /**
     6. 当扫描到服务的时候, 此代理方法会调用
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            return
        }
        
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        //找到指定服务UUID, 然后去扫描此服务的特性
        //services: 当扫描到服务时, 所有的服务会存在在外设的services属性中
        //for service:CBService in peripheral.services!{
            //将来服务和特征的UUID, 都在蓝牙厂商提供的文档中
            // 假设服务的UUID为 123456
            //if service.uuid.uuidString=="123456"{
                //扫描此服务的特性
                //Characteristics: 特征
                //如果特征传nil, 代表扫描所有特征
                //peripheral.discoverCharacteristics(nil, for: service)
            //}
        //}
    }
    
    /**
     7. 扫描到某个服务的某个特征时, 会调用的代理方法
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            return
        }
        for caracteristic in service.characteristics! {
            switch caracteristic.uuid.description {
            case "FFE1":
                print("")
                peripheral.setNotifyValue(true, for: caracteristic)
            case "2A37":
                print("")
                peripheral.readValue(for: caracteristic)
            case "2A38":
                print("")
                peripheral.readValue(for: caracteristic)
            default: break
            }
        }
    }
    
//    func peripheral(peripheral:CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCaracteristic, error:NSError?) {
//        if error != nil {
//            return
//        }
//
//        switch characteristic.UUID.description {
//        case "FFE1":
//            self.writeCharacteristic = characteristic
//            let string = NSString(data:characteristic.value!, encoding:NSUTF8StringEncoding)
//            let response = "OK"
//            let data = response.data(using: String.Encoding.utf8)
//            peripheral.writeValue(data!, forCharacteristic: self.writeCHaracteristic, type:CBCharacteristicWriteType.WithoutResponse)
//        default:
//            break
//
//        }
//    }
    
    //接收蓝牙通知，一般很少用
//    func peripheral(peripheral:CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteriatic, error:NSError?) {
//        if error != nil {
//            return
//        }
//        if characteristic.isNotifying {
//            peripheral.readValueForCharacteristic(characteristic)
//        }else {
//            central!.cancelPeripheralConnection(self.peripheral)
//        }
//    }
    
    //写入数据
    func writeValue(serviceUUID:String, characteristicUUID:String, peripheral:CBPeripheral, data: Data) {
        peripheral.writeValue(data, for: self.writeCharacteristic, type:CBCharacteristicWriteType.withResponse)
    }
    
    //检测数据写入是否成功
    func peripheral(peripheral:CBPeripheral, didWriteValueForCHaracteristic characteristic:CBCharacteristic, error:NSError?) {
        if error != nil {
            
        }else {
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if connectClouse != nil {
            connectClouse = nil
        }
    }
    
    //蓝牙断开链接时调用
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        peripheralConnect?.isConnect = false
        peripheralConnect = nil
        //SVProgressHUD.showError(withStatus: "当前连接失败!")
        if connectClouse != nil {
            connectClouse!()
        }
    }
}

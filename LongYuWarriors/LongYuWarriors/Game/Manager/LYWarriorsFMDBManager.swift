//
//  LYWarriorsFMDBManager.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/22.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import FMDB

class LYWarriorsFMDBManager: NSObject {
    static var shared = LYWarriorsFMDBManager()
    private var LYWarriors_RoleInterface = "LYWarriors_RoleInterface"+"_"+LYWarriorsUserInfo.shared.userId

    private lazy var queue: FMDatabaseQueue = {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String) + "/LYWarriorsDataInfo.db"
        let que = FMDatabaseQueue(path: path)
        return que
    }()

    private override init() {
        super.init()
        createTable()
    }

    private func createTable(){
        let sql = "CREATE TABLE IF NOT EXISTS \(LYWarriors_RoleInterface) (RoleId TEXT PRIMARY KEY NOT NULL, RoleInterfaceVO BLOB, create_date TEXT DEFAULT (datetime('now','localtime')));"//blob
        let rray : [String] = [sql]
        for sqlStr in rray {
            queue.inTransaction { (db, rollback) in
                let res = db.executeStatements(sqlStr)
                if !res {
                    print("失败")
                    rollback.pointee = true
                }
            }
        }
    }
    
    func loadRoleInterface() -> [LYWarriorsRoleInterface] {
        var roleInterfaceList: [LYWarriorsRoleInterface] = []
        let sql = "SELECT * FROM \(LYWarriors_RoleInterface)"
        
        queue.inDatabase { (db) in
            guard let resultSet = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            while resultSet.next() {
                let jsonData = resultSet.data(forColumn: "RoleInterfaceVO")
                let vo = NSKeyedUnarchiver.unarchiveObject(with: jsonData!)
                if let roleInterfaceVO = vo as? LYWarriorsRoleInterface{
                    roleInterfaceList.append(roleInterfaceVO)
                }
            }
        }
        return roleInterfaceList
    }
    
    func saveRoleInterface(roleInterface: LYWarriorsRoleInterface) {
        let sql = "INSERT INTO \(LYWarriors_RoleInterface) (RoleId,RoleInterfaceVO) VALUES (?,?)"
        
        queue.inTransaction { (db, rollback) in
            let roleId = roleInterface.id!
            let roleInterfaceData = NSKeyedArchiver.archivedData(withRootObject: roleInterface)
            let res = db.executeUpdate(sql, withArgumentsIn: [roleId,roleInterfaceData])
            if !res {
                rollback.pointee = true
                return
            }
        }
    }
}

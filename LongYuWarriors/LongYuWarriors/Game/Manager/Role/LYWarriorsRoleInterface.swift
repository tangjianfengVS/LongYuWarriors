//
//  LYWarriorsRoleInterface.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/21.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsRoleInterface: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "NAME")
        aCoder.encode(grade, forKey: "GRADE")
        aCoder.encode(id, forKey: "ID")
        aCoder.encode(professionalType.rawValue, forKey: "LYWarriorsProfessionalStr")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "NAME") as! String
        grade = aDecoder.decodeObject(forKey: "GRADE") as! Int
        id = aDecoder.decodeObject(forKey: "ID") as! String
        let professionalStr = aDecoder.decodeObject(forKey: "LYWarriorsProfessionalStr") as! String
        let str = LYWarriorsProfessionalType(rawValue: professionalStr)
        professionalType = str
    }
    
    let name: String!
    //等级
    let grade: Int!
    //id
    let id: String!
    //职业
    let professionalType: LYWarriorsProfessionalType!
    
    init(names: String, grades: Int, ids: String, professionalTypes: LYWarriorsProfessionalType) {
        name = names
        grade = grades
        id = ids
        professionalType = professionalTypes
        super.init()
    }
}

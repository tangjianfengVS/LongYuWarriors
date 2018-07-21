//
//  LYWarriorsTestPKList.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/13.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsTestPKList: UITableView {
    private let LYWarriorsTestPKListCellID = "LYWarriorsTestPKListCellID"
    private let funcArray = ["升龙击","冲击波","陨石坠落","崩山击","拔刀斩","普通攻击"]
    var clousre: ((LYWarriorsSkillFunc)->())?

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        rowHeight = 30
        dataSource = self
        delegate = self
        separatorStyle = UITableViewCellSeparatorStyle.none
        register(UITableViewCell.classForCoder(), forCellReuseIdentifier: LYWarriorsTestPKListCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LYWarriorsTestPKList: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LYWarriorsTestPKListCellID, for: indexPath)
        cell.textLabel?.text = funcArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if clousre != nil {
            clousre!(LYWarriorsSkillFunc(rawValue: funcArray[indexPath.row])!)
        }
    }
}


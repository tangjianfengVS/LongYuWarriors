//
//  LYWarriorsBluetoothVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/27.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsBluetoothVC: UIViewController {
    private var coverView: UIView!
    private let LYWarriorsBluetoothCellID = "LYWarriorsBluetoothCellID"
    
    private lazy var bluetoothManager: LYWarriorsBluetoothManager={
        let bluetooth = LYWarriorsBluetoothManager()
        bluetooth.myClouse = { [weak self] (res) in
            self?.listView.reloadData()
        }
        return bluetooth
    }()
    
    lazy var listView : UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.register(UINib.init(nibName: "LYWarriorsBluetoothCell", bundle: nil), forCellReuseIdentifier: LYWarriorsBluetoothCellID)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 80
        return view
    }()

    private init(view: UIView) {
        coverView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    class func beginSearch(VC: UIViewController, clouse: (()->())) {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.clear
        let bluetoothVC = LYWarriorsBluetoothVC(view: coverView)
        VC.addChildViewController(bluetoothVC)
        VC.view.addSubview(coverView)
        coverView.addSubview(bluetoothVC.view)
        
        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(VC.view)
        }
        bluetoothVC.view.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(coverView).inset(80)
            make.width.equalTo(250)
            make.center.equalTo(coverView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsBluetoothVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bluetoothManager.peripheralArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LYWarriorsBluetoothCellID, for: indexPath) as! LYWarriorsBluetoothCell
        cell.lyPeripheral = bluetoothManager.peripheralArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bluetoothManager.connect(indexPath: indexPath) {[weak self] in
            self?.listView.reloadData()
        }
    }
}

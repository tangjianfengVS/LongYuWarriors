//
//  LYWarriorsHomeSceneVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LYWarriorsHomeSceneVC: LYWarriorsBaseFuncVC {
    private var safeGaugeSize: (CGFloat,CGFloat)=(0,0)
    private let roleInterface: LYWarriorsRoleInterface!
    private let homeDetailVM = LYWarriorsHomeDetailVM()
    
    private lazy var showLoadVI: LYWarriorsHomeShowLoadVI={
        let view = UINib.init(nibName: "LYWarriorsHomeShowLoadVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsHomeShowLoadVI
        return view
    }()
    
    private lazy var scene: LYWarriorsCityScene={
        let scenes = LYWarriorsCityScene(sizes: CGSize(width: ScreenHeight, height: ScreenWidth), type: .floorType)
        scenes.scaleMode = .aspectFill
        return scenes
    }()
    
    private lazy var actionVI: LYWarriorsCityTopActionVI={
        let view = UINib.init(nibName: "LYWarriorsCityTopActionVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsCityTopActionVI
        view.clousre = {[weak self] type in
            switch type {
            case .duel:
                self?.scene.releaseRole()
                NotificationCenter.default.post(name: NSNotification.Name.init(LYWarriorsUpdateRootNotif), object: LYWarriorsDuelDetailVC(), userInfo: nil)
            default:
                break
            }
        }
        return view
    }()
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            //safeGaugeSize = (delegate?.safeLayoutGaugeSize())!
            delegate?.interfaceOrientations(type: .portrait)
        }
    }
    
    init(roleInterfaces: LYWarriorsRoleInterface) {
        roleInterface = roleInterfaces
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.addSubview(showLoadVI)
        loadData()
        
        showLoadVI.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func setupUI() {
        if let skView = view as? SKView {
            skView.presentScene(scene)
        }
        view.addSubview(actionVI)

        actionVI.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            //make.top.equalTo(view).offset(safeGaugeSize.0)
            //make.bottom.equalTo(view).offset(-safeGaugeSize.1)
            make.height.equalTo(70)
        }
    }
    
    private func loadData(){
        homeDetailVM.synchronization(roleInterface: roleInterface) {[weak self] (res) in
            if res{
                self?.showLoadVI.removeFromSuperview()
                self?.setupUI()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("游戏Home释放")
    }
}

extension LYWarriorsHomeSceneVC: SafeLayoutProtocol{
    
}

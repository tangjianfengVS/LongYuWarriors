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

class LYWarriorsHomeSceneVC: UIViewController {
    private var safeGaugeSize: (CGFloat,CGFloat)=(0,0)
    
    private lazy var scene: LYWarriorsCityScene={
        let scenes = LYWarriorsCityScene(sizes: UIScreen.main.bounds.size, type: .floorType)
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
            safeGaugeSize = (delegate?.safeLayoutGaugeSize())!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let skView = view as? SKView {
            skView.presentScene(scene)
        }
        delegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(actionVI)
        
        actionVI.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(safeGaugeSize.0)
            make.bottom.equalTo(view).offset(-safeGaugeSize.1)
            make.width.equalTo(100)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
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

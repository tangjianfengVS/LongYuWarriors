//
//  LYWarriorsGameSceneVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/21.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LYWarriorsGameSceneVC: UIViewController {
    private var roleDefier: LYWarriorsRole!
    //MARK : 场景
    private(set) lazy var scene: LYWarriorsScene = {
        let scenes = LYWarriorsScene(sizes: UIScreen.main.bounds.size, type: .floorType)
        scenes.scaleMode = .aspectFill
        return scenes
    }()
    //MARK : 技能
    private(set) lazy var skillFunc: LYWarriorsSkillFuncView = {
        let skill = LYWarriorsSkillFuncView.shared
        skill.clouse = {[weak self] (type) in
            if type == .raiseType{
                self?.scene.monster.raise()
            }
        }
        return skill
    }()
    
    private lazy var showVI: LYWarriorsDuelBeginShowVI={
        let view = UINib.init(nibName: "LYWarriorsDuelBeginShowVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsDuelBeginShowVI
        view.clousre = {
            
        }
        return view
    }()
    
    init(roleDefiers: LYWarriorsRole) {
        roleDefier = roleDefiers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let skView = view as? SKView {
            skView.presentScene(scene)
            //skView.showsFPS = true
            //skView.showsNodeCount = true
        }
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(skillFunc)
        view.addSubview(showVI)
        
        skillFunc.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(SkillFuncViewHeight)
            make.top.equalTo(view).offset(0)
        }
        showVI.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    deinit {
        scene.monster.removeFromParent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

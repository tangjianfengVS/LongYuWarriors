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
    
    /*
     *  场景
     *
     */
    private(set) lazy var scene: LYWarriorsScene = {
        let scenes = LYWarriorsScene.init(size: UIScreen.main.bounds.size)
        scenes.scaleMode = .aspectFill
        return scenes
    }()
    
    /*
     *    技能
     *
     */
    private(set) lazy var skillFunc: LYWarriorsSkillFuncView = {
        let skill = LYWarriorsSkillFuncView.shared
        skill.clouse = {[weak self] (type) in
            print(type)
        }
        return skill
    }()

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
        skillFunc.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(SkillFuncViewHeight)
            make.top.equalTo(view).offset(0)
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
}

//
//  LYWarriorsRole.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/23.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit
import UIKit

class LYWarriorsRole: SKSpriteNode {
    static let shared: LYWarriorsRole={
        let texture = SKTexture(imageNamed: "goblin_idle_0001")
        let role = LYWarriorsRole(texture: texture)
        return role
    }()
    
    /*
     *  属性
     */
    private(set) var id: String=""                             //ID
    private(set) var personFunc: LYWarriorsPersonFunc = .unKown//角色职业
    private(set) var userName: String=""                       //名称
    private(set) var skillFuncList: [Any] = []                 //技能集合
                                                               //技能设置（快捷键）
    
    private(set) var medalGrade: NSNumber=0                    //勋章等级
    private(set) var honorName: String=""                      //称号
    
    private let idleFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "Goblin_Idle")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"goblin_idle_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    private let walkFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "Goblin_Walk")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"goblin_walk_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    func idle() {
        let run = SKAction.animate(with: idleFarams, timePerFrame: 0.05)
        let repeatForeverRun = SKAction.repeatForever(run)
        self.run(repeatForeverRun)
    }
    
    func walk() {
        let run = SKAction.animate(with: walkFarams, timePerFrame: 0.05)
        let repeatForeverRun = SKAction.repeatForever(run)
        self.run(repeatForeverRun)
    }
}

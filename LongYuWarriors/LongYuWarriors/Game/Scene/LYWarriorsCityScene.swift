//
//  LYWarriorsCityScene.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit
import GameplayKit

class LYWarriorsCityScene: SKScene {
    private let spaceType: LYWarriorSpaceType!
    //MARK : 人物
    let monster = LYWarriorsRole.shared
    //map offset Size
    private lazy var mapOffsetTopSize: CGFloat = (sceneSpace.size.width - size.width)/2 + SpaceOffsetTopSize
    private lazy var mapOffsetSize = CGPoint(x: (sceneSpace.size.width - size.width)/2 + SpaceOffsetSize.width,
                                             y: (sceneSpace.size.height - size.height)/2 + SpaceOffsetSize.height)
    
    //MARK : 背景
    private lazy var sceneSpace: LYWarriorsCitySceneSpace = {
        let space = LYWarriorsCitySceneSpace(type: spaceType)
        space.position = CGPoint(x: size.width/2 + (size.width - space.size.width)/2, y: size.height/2)
        
        space.closure = {[weak self] (aimPoint)in
            let interval = TimeInterval.moveTime(aimPoint: aimPoint, monsterPoint: (self?.monster.position)!)
            self?.moveFiltration(aimPoint: aimPoint, interval: interval)
        }
        return space
    }()
    
    init(sizes: CGSize, type: LYWarriorSpaceType) {
        spaceType = type
        super.init(size: sizes)
        size = sizes
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    override func sceneDidLoad() {
        isUserInteractionEnabled = true
        addChild(sceneSpace)
        sceneSpace.addChild(monster)
        monster.position = position
    }
    
    private func moveFiltration(aimPoint: CGPoint, interval: TimeInterval){
        let pointBackground = CGPoint(x: sceneSpace.position.x, y: sceneSpace.position.y)
        if pointBackground.y <= size.height/2 - mapOffsetSize.y{//right
            if pointBackground.x >= size.width/2 - mapOffsetSize.x &&
                pointBackground.x <= size.width/2 + mapOffsetTopSize {
                //runSceneSpaceAction(x: sceneSpace.position.x - (Joystick.velocity?.x)! * 0.2, y: sceneSpace.position.y, duration: interval)
            }else{
                //interval = 0.04
            }
        }else if pointBackground.y >= size.height/2 + mapOffsetSize.y{//left
            if pointBackground.x >= size.width/2 - mapOffsetSize.x &&
                pointBackground.x <= size.width/2 + mapOffsetTopSize {
                //runSceneSpaceAction(x: sceneSpace.position.x - (Joystick.velocity?.x)! * 0.2, y: sceneSpace.position.y, duration: interval)
            }else{
                //interval = 0.04
            }
        }else if pointBackground.x >= size.width/2 + mapOffsetTopSize{//top
            if pointBackground.y >= size.height/2 - mapOffsetSize.y &&
                pointBackground.y <= size.height/2 + mapOffsetSize.y {
                //runSceneSpaceAction(x: sceneSpace.position.x, y: sceneSpace.position.y - (Joystick.velocity?.y)! * 0.2, duration: interval)
            }else{
                //interval = 0.04
            }
        }else if pointBackground.x <= size.width/2 - mapOffsetSize.x{//bottom
            if pointBackground.y >= size.height/2 - mapOffsetSize.y &&
                pointBackground.y <= size.height/2 + mapOffsetSize.y {
                //runSceneSpaceAction(x: sceneSpace.position.x, y: sceneSpace.position.y - (Joystick.velocity?.y)! * 0.2, duration: interval)
            }else{
                //interval = 0.04
            }
        }else{
            let moveBackground = SKAction.move(to: pointBackground, duration: interval)
            sceneSpace.run(moveBackground)
        }
        
        let monsterMove = SKAction.move(to: aimPoint, duration: interval)
        monster.walk()
        monster.run(monsterMove) {
            self.monster.idle()
        }
    }
    
    private func runSceneSpaceAction(x: CGFloat, y: CGFloat, duration: TimeInterval){
        let pointBackground = CGPoint(x: x, y: y)
        let moveBackground = SKAction.move(to: pointBackground, duration: duration)
        sceneSpace.run(moveBackground)
    }
    
    func releaseRole() {
        monster.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LYWarriorsCityScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        print("碰撞中...")
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("碰撞结束...",contact.contactPoint,contact.contactNormal)
    }
}

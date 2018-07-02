//
//  LYWarriorsScene.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/23.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit
import GameplayKit

class LYWarriorsScene: SKScene {
    private let spaceType: LYWarriorSpaceType!
    //map offset Size
    private lazy var mapOffsetTopSize: CGFloat = (sceneSpace.size.width - size.width)/2 + SpaceOffsetTopSize
    private lazy var mapOffsetSize = CGPoint(x: (sceneSpace.size.width - size.width)/2 + SpaceOffsetSize.width,
                                             y: (sceneSpace.size.height - size.height)/2 + SpaceOffsetSize.height)
    //MARK : 人物
    let monster = LYWarriorsRole.shared
    
    //MARK : 摇杆
    private var isJoystickTouchEnded: Bool=true
    private lazy var Joystick: LYWarriorsJoystick = {
        let tool = LYWarriorsJoystick(backdropNames: "dpad", thumbnNames: "joystick",
                                     thumbSizes: CGSize(width: 55, height: 55),
                                     sizes: CGSize(width: 105, height: 105))
        tool.delegate = self
        return tool
    }()
    //MARK : 背景
    private lazy var sceneSpace: LYWarriorsSceneSpace = {
        let space = LYWarriorsSceneSpace(type: spaceType)
        space.position = CGPoint(x: size.width/2 + (size.width - space.size.width)/2, y: size.height/2)
        return space
    }()
    
    init(sizes: CGSize, type: LYWarriorSpaceType) {
        spaceType = type
        super.init(size: sizes)
        size = sizes
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        isUserInteractionEnabled = true
        addChild(sceneSpace)
        sceneSpace.addChild(monster)
        addChild(Joystick)
        monster.position = CGPoint(x: 0, y: -size.height/2+100)
        Joystick.position = CGPoint(x: frame.maxX - Joystick.size.width/2 - 10, y: Joystick.size.width/2 + 10)
    }

    private func moveFiltration(aimPoint: CGPoint){        
        let pointBackground = CGPoint(x: sceneSpace.position.x,// - (Joystick.velocity?.x)! * 0.2,
                                      y: sceneSpace.position.y - (Joystick.velocity?.y)! * 0.2)
        var interval: TimeInterval = 0.08
        if pointBackground.y <= size.height/2 - mapOffsetSize.y{//right
            if pointBackground.x >= size.width/2 - mapOffsetSize.x &&
                pointBackground.x <= size.width/2 + mapOffsetTopSize {
                runSceneSpaceAction(x: sceneSpace.position.x - (Joystick.velocity?.x)! * 0.2, y: sceneSpace.position.y, duration: interval)
            }else{
                interval = 0.04
            }
        }else if pointBackground.y >= size.height/2 + mapOffsetSize.y{//left
            if pointBackground.x >= size.width/2 - mapOffsetSize.x &&
                pointBackground.x <= size.width/2 + mapOffsetTopSize {
                runSceneSpaceAction(x: sceneSpace.position.x - (Joystick.velocity?.x)! * 0.2, y: sceneSpace.position.y, duration: interval)
            }else{
                interval = 0.04
            }
        }else if pointBackground.x >= size.width/2 + mapOffsetTopSize{//top
            if pointBackground.y >= size.height/2 - mapOffsetSize.y &&
                pointBackground.y <= size.height/2 + mapOffsetSize.y {
                runSceneSpaceAction(x: sceneSpace.position.x, y: sceneSpace.position.y - (Joystick.velocity?.y)! * 0.2, duration: interval)
            }else{
                interval = 0.04
            }
        }else if pointBackground.x <= size.width/2 - mapOffsetSize.x{//bottom
            if pointBackground.y >= size.height/2 - mapOffsetSize.y &&
                pointBackground.y <= size.height/2 + mapOffsetSize.y {
                runSceneSpaceAction(x: sceneSpace.position.x, y: sceneSpace.position.y - (Joystick.velocity?.y)! * 0.2, duration: interval)
            }else{
                interval = 0.04
            }
        }else{
            let moveBackground = SKAction.move(to: pointBackground, duration: interval)
            sceneSpace.run(moveBackground)
        }
        let monsterMove = SKAction.move(to: aimPoint, duration: interval)
        monster.run(monsterMove)
    }
    
    private func runSceneSpaceAction(x: CGFloat, y: CGFloat, duration: TimeInterval){
        let pointBackground = CGPoint(x: x, y: y)
        let moveBackground = SKAction.move(to: pointBackground, duration: duration)
        sceneSpace.run(moveBackground)
    }

    override func didMove(to view: SKView) {
        monster.idle()
    }
}

extension LYWarriorsScene: LYWarriorsJoystickProtocol{
    func joystickBegan(Joystick: LYWarriorsJoystick, touches: Set<UITouch>, event: UIEvent) {
        
    }
    
    func joystickCanceled(Joystick: LYWarriorsJoystick, touches: Set<UITouch>, event: UIEvent) {
        
    }
    
    func joystickMoved(Joystick: LYWarriorsJoystick,touches: Set<UITouch>, event: UIEvent) {
        if OpenAngleRotate{
            monster.zRotation = Joystick.rotateAngle
        }
        if isJoystickTouchEnded{
            monster.walk()
            isJoystickTouchEnded = false
        }
        if Joystick.velocity == CGPoint(x: 0, y: 0) {
            Joystick.trackingHandler = {[weak self] in
                let point = CGPoint(x: (self?.monster.position.x)! + (self?.Joystick.velocity?.x)! * 0.2,
                                    y: (self?.monster.position.y)! + (self?.Joystick.velocity?.y)! * 0.2)
                if point.y < (self?.monster.position.y)! && (self?.monster.direction)!{
                    self?.monster.direction = false
                }else if point.y > (self?.monster.position.y)! && !(self?.monster.direction)!{
                    self?.monster.direction = true
                }
                self?.moveFiltration(aimPoint: point)
            }
        }
    }
    
    func joystickEnded(Joystick: LYWarriorsJoystick,touches: Set<UITouch>, event: UIEvent) {
        isJoystickTouchEnded = true
        monster.idle()
    }
}

extension LYWarriorsScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        print("碰撞中...")
    }

    func didEnd(_ contact: SKPhysicsContact) {
        print("碰撞结束...",contact.contactPoint,contact.contactNormal)
    }
}

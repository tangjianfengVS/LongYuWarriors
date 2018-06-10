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
    private var isJoystickTouchEnded: Bool=true
    private lazy var monster: LYWarriorsRole = LYWarriorsRole.shared
    
    private lazy var Joystick: LYWarriorsJoystick = {
        let tool = LYWarriorsJoystick(backdropNames: "dpad", thumbnNames: "joystick",
                                     thumbSizes: CGSize(width: 55, height: 55),
                                     sizes: CGSize(width: 100, height: 100))
        tool.delegate = self
        return tool
    }()
    
    override func sceneDidLoad() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.black
        let background = SKSpriteNode(imageNamed: "Snip20180610_3")
        background.size = size
        addChild(background)
        addChild(monster)
        addChild(Joystick)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        monster.position = CGPoint(x: frame.midX, y: frame.midY)
        Joystick.position = CGPoint(x: frame.maxX - Joystick.size.width/2 - 10, y: Joystick.size.width/2 + 10)
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
        monster.zRotation = Joystick.rotateAngle
        if isJoystickTouchEnded{
            monster.walk()
            isJoystickTouchEnded = false
        }
        if Joystick.velocity == CGPoint(x: 0, y: 0) {
            Joystick.trackingHandler = {[weak self] in
                let point = CGPoint(x: (self?.monster.position.x)! + (self?.Joystick.velocity?.x)! * 0.2,
                                    y: (self?.monster.position.y)! + (self?.Joystick.velocity?.y)! * 0.2)
                let move = SKAction.move(to: point, duration: 0.1)
                self?.monster.run(move)
            }
        }
    }
    
    func joystickEnded(Joystick: LYWarriorsJoystick,touches: Set<UITouch>, event: UIEvent) {
        isJoystickTouchEnded = true
        monster.idle()
    }
}

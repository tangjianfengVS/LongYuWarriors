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
    //MARK : 人物
    private(set) lazy var monster: LYWarriorsRole = LYWarriorsRole.shared
    //MARK : 摇杆
    private var isJoystickTouchEnded: Bool=true
    private lazy var Joystick: LYWarriorsJoystick = {
        let tool = LYWarriorsJoystick(backdropNames: "dpad", thumbnNames: "joystick",
                                     thumbSizes: CGSize(width: 55, height: 55),
                                     sizes: CGSize(width: 100, height: 100))
        tool.delegate = self
        return tool
    }()
    //MARK : 背景
    private lazy var backgroundNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Snip20180610_3")
        node.size = CGSize(width: 400, height: 950)
        return node
    }()
    //MARK : 运动范围
    private lazy var monsterCenterRect: CGRect={
        let centerSize = CGSize(width: 200, height: 200)
        let offsetX = (self.backgroundNode.frame.height-centerSize.width)/2
        let offsetY = (self.backgroundNode.frame.width-centerSize.height)/2
        return CGRect(x: offsetY, y: offsetX, width: centerSize.width, height: centerSize.height)
    }()
    
    override func sceneDidLoad() {
        isUserInteractionEnabled = true
        addChild(backgroundNode)
        backgroundNode.addChild(monster)
        addChild(Joystick)
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        monster.position = CGPoint(x: size.width/2, y: monster.size.height)
        Joystick.position = CGPoint(x: frame.maxX - Joystick.size.width/2 - 10, y: Joystick.size.width/2 + 10)
    }
    
    /*  过滤
     *  背景移动:
     *  实体Rect
     *
     */
    private func moveFiltration(aimPoint: CGPoint){
        let backgroundFrame = CGRect(x: backgroundNode.size.width/2 + monster.frame.minX,
                                     y: backgroundNode.size.height/2 + monster.frame.minY,
                                     width: monster.size.width, height: monster.size.height)
        let zeroFrame = CGRect(x: 0, y: 0, width: backgroundNode.size.width, height: backgroundNode.size.height)
        
        if !zeroFrame.contains(backgroundFrame) {
            var newPoint = aimPoint
            if backgroundFrame.minX <= zeroFrame.minX{
                newPoint = CGPoint(x: newPoint.x - backgroundFrame.minX, y: newPoint.y)
            }else if backgroundFrame.minY <= zeroFrame.minY{
                newPoint = CGPoint(x: newPoint.x, y: newPoint.y - backgroundFrame.minY)
            }else if backgroundFrame.maxY >= zeroFrame.maxY{
                newPoint = CGPoint(x: newPoint.x, y: newPoint.y - backgroundFrame.maxY + zeroFrame.maxY)
            }else if backgroundFrame.maxX >= zeroFrame.maxX{
                newPoint = CGPoint(x: newPoint.x - backgroundFrame.maxX + zeroFrame.maxX, y: newPoint.y)
            }
            let move = SKAction.move(to: newPoint, duration: 0.1)
            monster.run(move)
        }else{
            //判断 backgroundNode边距
            let pointBackground = CGPoint(x: backgroundNode.position.x - (Joystick.velocity?.x)! * 0.2,
                                          y: backgroundNode.position.y - (Joystick.velocity?.y)! * 0.2)
            //print(pointBackground)
            var interval: TimeInterval = 0.05
            if pointBackground.y <= 0 {
                if pointBackground.x >= -50 && pointBackground.x - size.width <= 50{
                    let newPointBackground = CGPoint(x: pointBackground.x, y: 0)
                    let moveBackground = SKAction.move(to: newPointBackground, duration: 0.05)
                    backgroundNode.run(moveBackground)
                }else{
                    interval = 0.1
                }
            }else if pointBackground.y >= size.height{
                if pointBackground.x >= -50 && pointBackground.x - size.width <= 50{
                    let newPointBackground = CGPoint(x: pointBackground.x, y: size.height)
                    let moveBackground = SKAction.move(to: newPointBackground, duration: 0.05)
                    backgroundNode.run(moveBackground)
                }else{
                    interval = 0.1
                }
            }else if pointBackground.x - size.width >= 50{
                if pointBackground.y >= 0 && pointBackground.y <= size.height{
                    let newPointBackground = CGPoint(x: size.width + 50, y: pointBackground.y)
                    let moveBackground = SKAction.move(to: newPointBackground, duration: 0.05)
                    backgroundNode.run(moveBackground)
                }else{
                    interval = 0.1
                }
            }else if pointBackground.x <= -50{
                if pointBackground.y >= 0 && pointBackground.y <= size.height{
                    let newPointBackground = CGPoint(x: -50, y: pointBackground.y)
                    let moveBackground = SKAction.move(to: newPointBackground, duration: 0.05)
                    backgroundNode.run(moveBackground)
                }else{
                    interval = 0.1
                }
            }else{
                let moveBackground = SKAction.move(to: pointBackground, duration: 0.05)
                backgroundNode.run(moveBackground)
            }
            let monsterMove = SKAction.move(to: aimPoint, duration: interval)
            monster.run(monsterMove)
        }
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
                if (self?.Joystick.velocity?.x)! < 0 && (self?.monster.direction)!{
                    //self?.monster.direction = false
                    print("推")
                }else if (self?.Joystick.velocity?.x)! > 0 && !(self?.monster.direction)!{
                    //self?.monster.direction = true
                    print("进")
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

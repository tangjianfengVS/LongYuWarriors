//
//  LYWarriorsJoystick.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/22.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import SpriteKit

enum MasterLocationType: NSInteger {
    case centre=1
    case bicyclic=2
    case tricyclic=3
    case tetracycline=4
}

class LYWarriorsJoystick: SKSpriteNode{
    private(set) var thumbnName: String!
    private(set) var backdropName: String!
    private(set) var thumbSize: CGSize!
    private(set) var rotateAngle: CGFloat=0
    private(set) var velocity: CGPoint?   //速度
    
    fileprivate(set) var backdropNode: SKSpriteNode?
    fileprivate(set) var thumbNode: SKSpriteNode?
    fileprivate(set) var isTracking: Bool=false
    var delegate: LYWarriorsJoystickProtocol?
    var trackingHandler: (()->())?
    
    class func joystickWithBackdropImageNamed(backdropName: String,
                                                thumbnName: String,
                                                 thumbSize: CGSize,
                                                      size: CGSize)-> LYWarriorsJoystick{
        return LYWarriorsJoystick(backdropNames: backdropName,
                                    thumbnNames: thumbnName,
                                     thumbSizes: thumbSize,
                                          sizes: size)
    }
    
    init(backdropNames: String, thumbnNames: String, thumbSizes: CGSize, sizes: CGSize) {
        thumbnName = thumbnNames
        backdropName = backdropNames
        thumbSize = thumbSizes
        let texture = SKTexture(imageNamed: backdropNames)
        super.init(texture: texture, color: .cyan, size: texture.size())
        isUserInteractionEnabled = true
        size = sizes
        
        let backdropNodes = SKSpriteNode(imageNamed: backdropName)
        backdropNode = backdropNodes
        backdropNode!.size = size
        addChild(backdropNode!)
        
        let thumbNodes = SKSpriteNode(imageNamed: thumbnName)
        thumbNode = thumbNodes
        thumbNode!.size = thumbSizes
        addChild(thumbNode!)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(listen))
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    @objc private func listen(){
        if isTracking && trackingHandler != nil {
            trackingHandler!()
        }
    }

    private func reduction() {
        isTracking = false
        velocity = CGPoint.zero
        let reduction = SKAction.move(to: CGPoint.zero, duration: 0.2)
        reduction.timingMode = .easeOut
        thumbNode!.run(reduction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LYWarriorsJoystick {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = delegate?.joystickBegan(Joystick: self, touches: touches, event: event!){
            
        }
        for touch in touches {
            let touchPoint = touch.location(in: self)
            if !isTracking && thumbNode!.frame.contains(touchPoint){
                isTracking = true
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = delegate?.joystickMoved(Joystick: self, touches: touches, event: event!){
            
        }
        for touch in touches {
            let touchPoint = touch.location(in: self)
            let res = sqrtf(powf((Float(touchPoint.x - thumbNode!.position.x)), 2) +
                            powf((Float(touchPoint.y - thumbNode!.position.y)), 2))
            if isTracking && CGFloat(res) < backdropNode!.size.width * 2{
                
                let sqrtfPoint = sqrtf(powf(Float(touchPoint.x), 2) + powf(Float(touchPoint.y), 2))
                if sqrtfPoint <= Float(thumbNode!.size.width) {
                    let moveDifference = CGPoint(x: touchPoint.x, y: touchPoint.y)
                    thumbNode!.position = CGPoint(x: moveDifference.x, y: moveDifference.y)
                }else{
                    let magV: CGFloat = sqrt(touchPoint.x * touchPoint.x + touchPoint.y * touchPoint.y)
                    let x: CGFloat = touchPoint.x / magV * thumbNode!.size.width
                    let y: CGFloat = touchPoint.y / magV * thumbNode!.size.width
                    thumbNode!.position = CGPoint(x: x, y: y)
                }
            }
        }
        velocity = CGPoint(x: thumbNode!.position.x, y: thumbNode!.position.y)
        rotateAngle = -atan2(thumbNode!.position.x, thumbNode!.position.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = delegate?.joystickEnded(Joystick: self, touches: touches, event: event!){
            
        }
        reduction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = delegate?.joystickCanceled(Joystick: self, touches: touches, event: event!){
            
        }
        reduction()
    }
}

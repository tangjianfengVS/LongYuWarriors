//
//  LYWarriorsCitySceneSpace.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit

class LYWarriorsCitySceneSpace: SKSpriteNode {
    private let spaceType: LYWarriorSpaceType!
    var closure: ((CGPoint)->())?
    
    private let touchNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "touch_0001")
        node.size = CGSize(width: 45, height: 60)
        return node
    }()
    
    private lazy var touchAnimation: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "Touch")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"touch_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    private lazy var bottomNode: SKSpriteNode={
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: SpaceOffsetSize.width, height: size.height+SpaceOffsetSize.height*2)
        node.position = CGPoint(x: (size.width + SpaceOffsetSize.width)/2, y: 0)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = UInt32(LYWarriorsMarginType.marginType.rawValue)
        return node
    }()
    
    init(type: LYWarriorSpaceType) {
        spaceType = type
        let texture = SKTexture(imageNamed: "Snip20180610_3")
        super.init(texture: texture, color: UIColor.cyan, size: CGSize(width: 950, height: ScreenWidth/2))
        isUserInteractionEnabled = true
        setupUI()
    }
    
    private func setupUI(){
        addChild(bottomNode)
    }
    
    func touch(center: CGPoint) {
        if children.contains(touchNode){
            return
        }
        addChild(touchNode)
        touchNode.position = center
        let run = SKAction.animate(with: touchAnimation, timePerFrame: CitMoveTime)
        let repeatForeverRun = SKAction.repeat(run, count: 1)
        touchNode.run(repeatForeverRun) {
            self.touchNode.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LYWarriorsCitySceneSpace{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        touch(center: touchPoint!)
        if closure != nil {
            closure!(touchPoint!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

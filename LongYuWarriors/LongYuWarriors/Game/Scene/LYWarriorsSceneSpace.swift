//
//  LYWarriorsSceneSpace.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/25.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit

enum LYWarriorSpaceType {
    case floorType
}

class LYWarriorsSceneSpace: SKSpriteNode {
    private let spaceType: LYWarriorSpaceType!
    
    private lazy  var topNode: SKSpriteNode={
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: SpaceOffsetTopSize, height: size.height+SpaceOffsetSize.height*2)
        node.position = CGPoint(x: -(size.width + SpaceOffsetTopSize)/2, y: 0)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = 2
        return node
    }()
    private lazy  var rightNode: SKSpriteNode={
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: size.width, height: SpaceOffsetSize.height)
        node.position = CGPoint(x: 0, y: (size.height + SpaceOffsetSize.height)/2)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = 2
        return node
    }()
    private lazy  var bottomNode: SKSpriteNode={
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: SpaceOffsetSize.width, height: size.height+SpaceOffsetSize.height*2)
        node.position = CGPoint(x: (size.width + SpaceOffsetSize.width)/2, y: 0)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = 2
        return node
    }()
    private lazy  var leftNode: SKSpriteNode={
        let node = SKSpriteNode(imageNamed: "bg")
        node.size = CGSize(width: size.width, height: SpaceOffsetSize.height)
        node.position = CGPoint(x: 0, y: -(size.height + SpaceOffsetSize.height)/2)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = 2
        return node
    }()
    
    init(type: LYWarriorSpaceType, positions: CGPoint) {
        spaceType = type
        let texture = SKTexture(imageNamed: "Snip20180610_3")
        super.init(texture: texture, color: UIColor.cyan, size: CGSize(width: 400, height: 950))
        position = positions
        setupUI()
    }

    private func setupUI(){
        addChild(topNode)
        addChild(rightNode)
        addChild(bottomNode)
        addChild(leftNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

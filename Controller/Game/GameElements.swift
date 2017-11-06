//
//  GameElements.swift
//  StackTheStack
//
//  Created by Michael Craun on 10/31/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import GameplayKit

enum Object: Int {
    case short = 0
    case medium = 1
    case tall = 2
    case shortLong = 3
    case mediumLong = 4
    case tallLong = 5
}

extension GameScene {
    
    func createGameElements() {
        
        startingObject = self.childNode(withName: "startingObject") as? SKSpriteNode
        startingObject?.physicsBody = SKPhysicsBody(rectangleOf: startingObject!.frame.size)
        startingObject?.physicsBody?.linearDamping = 0
        startingObject?.physicsBody?.categoryBitMask = startingObjectCategory
        startingObject?.physicsBody?.collisionBitMask = 0
        startingObject?.physicsBody?.contactTestBitMask = playerObjectCategory
        startingObject?.physicsBody?.affectedByGravity = false
        startingObject?.physicsBody?.isDynamic = false
        
        heightLabel = self.childNode(withName: "heightLabel") as? SKLabelNode
        multiplierLabel = self.childNode(withName: "multiplierLabel") as? SKLabelNode
        
        nextObjectLabel = self.childNode(withName: "nextObjectLabel") as? SKLabelNode
        nextObjectRest = self.childNode(withName: "nextObjectRest") as? SKSpriteNode
        
        nextObjectRest?.physicsBody = SKPhysicsBody(rectangleOf: nextObjectRest!.frame.size)
        nextObjectRest?.physicsBody?.collisionBitMask = 0
        nextObjectRest?.physicsBody?.affectedByGravity = false
        nextObjectRest?.physicsBody?.isDynamic = false
        
        if let musicURL = Bundle.main.url(forResource: "gameMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        pauseButton = self.childNode(withName: "pauseButton") as? SKSpriteNode
        
        powerUp0CountDownLabel = self.childNode(withName: "powerUp0CountDown") as? SKLabelNode
        powerUp0CountDown = GameHandler.sharedInstance.platformGrowthCount
        
        powerUp1CountLabel = self.childNode(withName: "powerUp1Count") as? SKLabelNode
        numOfLightBlock = GameHandler.sharedInstance.numOfLightBlock
        
        powerUp2CountLabel = self.childNode(withName: "powerUp2Count") as? SKLabelNode
        numOfHeavyBlock = GameHandler.sharedInstance.numOfHeavyBlock
        
        powerUp3CountLabel = self.childNode(withName: "powerUp3Count") as? SKLabelNode
        numOfBlockDelete = GameHandler.sharedInstance.numOfBlockDelete
        
        displayNextObject()
        
    }
    
    func displayNextObject() {
        
        nextObjectLabel.removeAllChildren()
        let randomObjectType = Object(rawValue: GKRandomSource.sharedRandom().nextInt(upperBound: 6))!
        guard let newObject = createObject(type: randomObjectType) else { fatalError("NO OBJECT CREATED") }
        nextObjectLabel.addChild(newObject)
        
    }
    
    func createObject(type: Object) -> SKSpriteNode? {
        
        var objectSprite = SKSpriteNode()
        
        switch type {
        case .short: objectSprite = createSmallSprite()
        case .medium: objectSprite = createMediumSprite()
        case .tall: objectSprite = createTallSprite()
        case .shortLong: objectSprite = createShortLongSprite()
        case .mediumLong: objectSprite = createMediumLongSprite()
        case .tallLong: objectSprite = createTallLongSprite()
        }
        
        objectSprite.name = "object"
        objectSprite.physicsBody = SKPhysicsBody(rectangleOf: objectSprite.frame.size)
        objectSprite.physicsBody?.categoryBitMask = playerObjectCategory
        objectSprite.physicsBody?.contactTestBitMask = startingObjectCategory //| playerObjectCategory
        objectSprite.zPosition = 1
        
        return objectSprite
        
    }
}

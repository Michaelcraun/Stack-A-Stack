//
//  StartElements.swift
//  StackTheStack
//
//  Created by Michael Craun on 11/1/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import SpriteKit
import GameKit
import UserNotifications

extension StartScene {
    
    func createElements() {
        
//        UNUserNotificationCenter.addObserver(self, forKeyPath: "pauseGame", context: )
        
        playGameButton = self.childNode(withName: "startGameButton") as? SKShapeNode
        playGameButton?.path = CGPath(roundedRect: CGRect(x: -75, y: -25, width: 150, height: 50),
                                      cornerWidth: 25,
                                      cornerHeight: 25,
                                      transform: nil)
        
        if let musicURL = Bundle.main.url(forResource: "gameMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        createBackground()
        
    }
    
    func createBackground() {
        
        let width = self.view!.frame.width
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            
            let randomObjectType = Object(rawValue: GKRandomSource.sharedRandom().nextInt(upperBound: 6))!
            let xPos = GKRandomSource.sharedRandom().nextInt(upperBound: Int(width))
            
            let newObject = self.createObject(type: randomObjectType)
            newObject?.position = CGPoint(x: CGFloat(xPos - Int(width / 2)), y: self.view!.frame.height + 500)
            
            self.addChild(newObject!)
            
            }, SKAction.wait(forDuration: 0.5)])))
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
        objectSprite.zPosition = 1
        objectSprite.alpha = 0.5
        
        return objectSprite
        
    }
    
    func firstRun() {
        
        
    }
}

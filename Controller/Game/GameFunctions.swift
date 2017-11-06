//
//  GameFunctions.swift
//  StackTheStack
//
//  Created by Michael Craun on 10/31/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func startTimers() {
        
        let timeAction = SKAction.repeatForever(SKAction.sequence([SKAction.run({
            
            self.powerUp0CountDown -= 1
            
        }), SKAction.wait(forDuration: 1)]))
        
        powerUp0CountDownLabel?.run(timeAction)
        
    }
    
    func spawnObject(atPosition point: CGPoint) {
        
        self.run(objectPlacedSound)
        let objectToPlace = self.nextObjectLabel.childNode(withName: "object")
        objectToPlace?.position = point
        
        if lightBlockIsEnabled {
            objectToPlace?.physicsBody?.density = 0.1
            lightBlockIsEnabled = false
        }
        
        //TODO: Test on device
        if heavyBlockIsEnabled {
            objectToPlace?.physicsBody?.density = 2.0
            heavyBlockIsEnabled = true
        }
        
        displayNextObject()
        self.addChild(objectToPlace!)
        
    }
    
    func calculateScore() {
        
        var index = 0
//        index = 10
        currentScore = 0
        
        self.enumerateChildNodes(withName: "object") { (node: SKNode, nil) in
            
            index += 1
            self.multiplier = 1 + index / 10
            self.currentScore += 1 * self.multiplier
            
        }
        
        print(index)
        print(multiplier)
        print(currentScore)
        
    }
    
    func updateMultiplierLabel(withMultiplier multiplier: Int, andColor color: UIColor) {
        
        print("updateMultiplierLabel")
        run(multiplierUpSound)
        
        multiplierLabel?.fontSize += 10
        multiplierLabel?.text = "x\(multiplier)"
//        multiplierLabel?.fontColor = color
//        multiplierLabel?.colorBlendFactor = 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { self.multiplierLabel?.fontSize -= 10 }
        
    }
    
    func gameOver() {
        
        backgroundMusic.removeFromParent()
        
        let transition = SKTransition.fade(withDuration: 1)
        if let gameOverScene = SKScene(fileNamed: "GameOverScene") {
            gameOverScene.scaleMode = .aspectFit
            self.view?.presentScene(gameOverScene, transition: transition)
        }
    }
    
    func platformGrowthPowerUp() {
        
        if !powerUp0IsEnabled {

            powerUp0IsEnabled = true
        
            startingObject?.run(SKAction.resize(toWidth: startingObject!.frame.width * 2, duration: 0.5), completion: {
                
                self.startingObject?.physicsBody = SKPhysicsBody(rectangleOf: self.startingObject!.frame.size)
                self.startingObject?.physicsBody?.linearDamping = 0
                self.startingObject?.physicsBody?.categoryBitMask = self.startingObjectCategory
                self.startingObject?.physicsBody?.collisionBitMask = 0
                self.startingObject?.physicsBody?.contactTestBitMask = self.playerObjectCategory
                self.startingObject?.physicsBody?.affectedByGravity = false
                
                self.startingObject?.texture = SKTexture(imageNamed: "starting.400")
                
            })
        }
    }
}

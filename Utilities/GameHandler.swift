//
//  Singleton.swift
//  StackTheStack
//
//  Created by Michael Craun on 11/1/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import Foundation
import SpriteKit

class GameHandler {
    
    let defaults = UserDefaults.standard
    var timer = Timer()
    
    var score: Int
    var highScore: Int
    
    var platformGrowthCount: Int
    var numOfLightBlock: Int
    var numOfHeavyBlock: Int
    var numOfBlockDelete: Int
    
    class var sharedInstance: GameHandler {
        
        struct Singleton {
            
            static let instance = GameHandler()
            
        }
        
        return Singleton.instance
        
    }
    
    init() {
        
        score = 0
        highScore = 0
        
        platformGrowthCount = 0
        numOfLightBlock = 0
        numOfHeavyBlock = 0
        numOfBlockDelete = 0
        
        highScore = defaults.integer(forKey: "highScore")
        numOfLightBlock = defaults.integer(forKey: "numOfLight")
        numOfHeavyBlock = defaults.integer(forKey: "numOfHeavy")
        numOfBlockDelete = defaults.integer(forKey: "numOfDelete")
        
    }
    
    func saveGameStats() {
        
        highScore = max(score, highScore)
        
        defaults.set(highScore, forKey: "highScore")
        defaults.synchronize()
        
    }
    
    func savePowerUps() {
        
        defaults.set(numOfLightBlock, forKey: "numOfLight")
        defaults.set(numOfHeavyBlock, forKey: "numOfHeavy")
        defaults.set(numOfBlockDelete, forKey: "numOfDelete")
        
    }
}

extension SKScene {
    
    func createSmallSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 50, height: 50)
        object.texture = SKTexture(imageNamed: "050.050")
        return object
        
    }
    
    func createMediumSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 50, height: 100)
        object.texture = SKTexture(imageNamed: "050.100")
        return object
        
    }
    
    func createTallSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 50, height: 200)
        object.texture = SKTexture(imageNamed: "050.200")
        return object
        
    }
    
    func createShortLongSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 100, height: 50)
        object.texture = SKTexture(imageNamed: "100.050")
        return object
        
    }
    
    func createMediumLongSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 100, height: 100)
        object.texture = SKTexture(imageNamed: "100.100")
        return object
        
    }
    
    func createTallLongSprite() -> SKSpriteNode {
        
        let object = SKSpriteNode()
        object.size = CGSize(width: 100, height: 200)
        object.texture = SKTexture(imageNamed: "100.200")
        return object
        
    }
}

//
//  GameScene.swift
//  StackTheStack
//
//  Created by Michael Craun on 10/31/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: Game Elements
    var startingObject: SKSpriteNode?
    var heightLabel: SKLabelNode?
    var multiplierLabel: SKLabelNode?
    var playerObjects = [SKNode?]()
    var nextObjectLabel: SKLabelNode!
    var nextObjectRest: SKSpriteNode?
    var createdObjects = [SKSpriteNode]()
    var pauseButton: SKSpriteNode?
    var powerUp0CountDownLabel: SKLabelNode?
    var powerUp1CountLabel: SKLabelNode?
    var powerUp2CountLabel: SKLabelNode?
    var powerUp3CountLabel: SKLabelNode?
    
    //MARK: Game Sounds
    let multiplierUpSound = SKAction.playSoundFileNamed("multiplierUp.mp3", waitForCompletion: false)
    let objectPlacedSound = SKAction.playSoundFileNamed("objectPlaced.mp3", waitForCompletion: false)
    let objectMisplacedSound = SKAction.playSoundFileNamed("objectMisplaced.mp3", waitForCompletion: true)
    var backgroundMusic: SKAudioNode!
    
    //MARK: Collision Categories
    let startingObjectCategory: UInt32 =    0x1 << 0
    let playerObjectCategory: UInt32 =      0x1 << 1
    let nextObjectRestCategory: UInt32 =    0x1 << 2
    
    //MARK: Game Variables
    var multiplier = 1 {
        willSet (newMultiplier) {
            print("multiplier: \(multiplier)")
            print("newMultiplier: \(newMultiplier)")
            print(newMultiplier == multiplier)
            
            if newMultiplier != multiplier {
                switch newMultiplier {
                case 1: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 2: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 3: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 4: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 5: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 6: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 7: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 8: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 9: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                case 10: updateMultiplierLabel(withMultiplier: newMultiplier, andColor: .blue)
                default: break
                }
            }
        }
//        didSet {
//        }
    }
    
    var powerUp0IsEnabled = false       //platform expansion
    var powerUp0CountDown: Int = 0 {
        didSet {
            if powerUp0CountDown <= 0 {
                powerUp0CountDownLabel?.run(SKAction.fadeOut(withDuration: 0.5))
            } else {
                powerUp0CountDownLabel?.run(SKAction.fadeIn(withDuration: 0.5))
                powerUp0CountDownLabel?.text = "\(self.powerUp0CountDown)"
            }
        }
    }
    
    var lightBlockIsEnabled = false       //light blocks
    var numOfLightBlock: Int = 0 {
        didSet {
            if numOfLightBlock != 0 {
                powerUp1CountLabel?.color = .green
            } else {
                powerUp1CountLabel?.color = .red
            }
            
            powerUp1CountLabel?.text = "\(numOfLightBlock)"
            GameHandler.sharedInstance.numOfLightBlock = numOfLightBlock
            
        }
    }
    
    var heavyBlockIsEnabled = false       //heavy blocks
    var numOfHeavyBlock: Int = 0 {
        didSet {
            if numOfHeavyBlock != 0 {
                powerUp2CountLabel?.color = .green
            } else {
                powerUp2CountLabel?.color = .red
            }
            
            powerUp2CountLabel?.text = "\(numOfHeavyBlock)"
            GameHandler.sharedInstance.numOfHeavyBlock = numOfHeavyBlock
        }
    }
    
    var blockDeleteIsEnabled = false       //delete a block
    var numOfBlockDelete: Int = 0 {
        didSet {
            if numOfBlockDelete != 0 {
                powerUp3CountLabel?.color = .green
            } else {
                powerUp3CountLabel?.color = .red
            }
            
            powerUp3CountLabel?.text = "\(numOfBlockDelete)"
            GameHandler.sharedInstance.numOfBlockDelete = numOfBlockDelete
        }
    }
    
    var currentScore = 0 {
        didSet {
            heightLabel?.text = "Current Score: \(self.currentScore)"
            GameHandler.sharedInstance.score = currentScore
        }
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        createGameElements()
        currentScore = 0
        
        startTimers()
        
        //MARK: Test
        numOfLightBlock = 10
        numOfHeavyBlock = 10
        numOfBlockDelete = 10
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let position = touch.previousLocation(in: self)
            let node = self.nodes(at: position).first
            
            if node?.name == "pauseButton" {
                
                switch self.isPaused {
                case true:
                    self.isPaused = false
                    pauseButton?.texture = SKTexture(imageNamed: "pause")
                case false:
                    self.isPaused = true
                    pauseButton?.texture = SKTexture(imageNamed: "play")
                }
                
            } else if node?.name == "powerUp0Button" || node?.name == "powerUp0CountDown" {
                
                if !self.isPaused {
                    if powerUp0CountDown <= 0 && !powerUp0IsEnabled {
                    
                        powerUp0CountDown = 120
                        platformGrowthPowerUp()
                        
                    } else {
                        if powerUp0CountDown > 0 {
                            //TODO: Ask user if they want to purchase more
                        }
                        
                        if powerUp0IsEnabled {
                            //TODO: Tell user powerup can only be used once per game
                        }
                    }
                }
                
            } else if node?.name == "powerUp1Button" || node?.name == "powerUp1Count" {
                if !self.isPaused {
                    if numOfLightBlock > 0  && !lightBlockIsEnabled {
                        
                        lightBlockIsEnabled = true
                        numOfLightBlock -= 1
                        
                    } else {
                        
                        
                    }
                }
                
            } else if node?.name == "powerUp2Button" || node?.name == "powerUp2Count" {
                if !self.isPaused {
                    if numOfHeavyBlock > 0 && !heavyBlockIsEnabled {
                        
                        heavyBlockIsEnabled = true
                        numOfHeavyBlock -= 1
                        
                    }
                }
                
            } else if node?.name == "powerUp3Button" || node?.name == "powerUp3Count" {
                if !self.isPaused {
                    if numOfBlockDelete > 0 && !blockDeleteIsEnabled {
                        
                        blockDeleteIsEnabled = true
                        numOfBlockDelete -= 1
                        
                    }
                }
                
            } else if node?.name == "object" && blockDeleteIsEnabled {
                if !self.isPaused {
                    
                    node?.removeFromParent()
                    blockDeleteIsEnabled = false
                    calculateScore()
                    
                }
                
            } else {
                if !self.isPaused {
                    
                    spawnObject(atPosition: position)
                    
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        calculateScore()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        self.enumerateChildNodes(withName: "object") { (node: SKNode, nil) in
            
            if node.position.x < 0 || node.position.x > self.frame.width || node.position.y < 0 {
                
                node.removeFromParent()
                self.run(self.objectMisplacedSound)
                self.gameOver()
                
            }
        }
    }
}

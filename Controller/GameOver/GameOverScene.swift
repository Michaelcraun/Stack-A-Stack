//
//  GameOverScene.swift
//  StackTheStack
//
//  Created by Michael Craun on 11/1/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    //MARK: Button Variables
    let buttonSound = SKAction.playSoundFileNamed("buttonPressed.mp3", waitForCompletion: true)
    var backgroundMusic: SKAudioNode!
    
    //MARK: UI Variables
    var currentScoreLabel: SKLabelNode?
    var highScoreLabel: SKLabelNode?
    var playAgainButton: SKShapeNode?
    
    //MARK: Game Variables
    var powerUp0CountDown = 0
    
    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        createElements()
        startTimers()
        
        currentScoreLabel?.text = "\(GameHandler.sharedInstance.score)"
        highScoreLabel?.text = "\(GameHandler.sharedInstance.highScore)"
        
        //IF NEW HIGH SCORE -> FIREWORKS?
        
        GameHandler.sharedInstance.saveGameStats()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let position = touch.previousLocation(in: self)
            let node = self.nodes(at: position).first
            
            if node?.name == "playAgainButton" || node?.name == "playAgainLabel" {
                
                run(buttonSound)
                
                let transition = SKTransition.fade(withDuration: 1)
                if let gameScene = SKScene(fileNamed: "GameScene") {
                    GameHandler.sharedInstance.platformGrowthCount = powerUp0CountDown
                    gameScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        enumerateChildNodes(withName: "object", using: { (node: SKNode, nil) in
            
            if node.position.y < -1000 {
                
                node.removeFromParent()
                
            }
        })
    }
    
    func startTimers() {
        
        let timeAction = SKAction.repeatForever(SKAction.sequence([SKAction.run({
            
            self.powerUp0CountDown -= 1
            
        }), SKAction.wait(forDuration: 1)]))
        
        run(timeAction)
        
    }
}

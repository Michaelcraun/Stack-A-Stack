//
//  StartScene.swift
//  StackTheStack
//
//  Created by Michael Craun on 11/1/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import SpriteKit

class StartScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: Sound Variables
    let playPressedSound = SKAction.playSoundFileNamed("buttonPressed.mp3", waitForCompletion: true)
    
    //MARK: Button Variables
    var playGameButton: SKShapeNode?
    var backgroundMusic: SKAudioNode!
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        createElements()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let position = touch.previousLocation(in: self)
            let node = self.nodes(at: position).first
            
            if node?.name == "startGameButton" || node?.name == "startGameLabel" {
                
                run(playPressedSound)
                
                let transition = SKTransition.fade(withDuration: 1)
                if let gameScene = SKScene(fileNamed: "GameScene") {
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
}

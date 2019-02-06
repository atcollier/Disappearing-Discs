//
//  GameOverScene.swift
//  Disappearing Discs
//
//  Created by Austin Collier on 2/5/19.
//  Copyright © 2019 Austin Collier. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene
{
    let clickSound = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Pusab")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 140
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let finalScoreLabel = SKLabelNode(fontNamed: "Pusab")
        finalScoreLabel.text = "Score: \(scoreNumber)"
        finalScoreLabel.fontSize = 70
        finalScoreLabel.fontColor = SKColor.white
        finalScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        finalScoreLabel.zPosition = 1
        self.addChild(finalScoreLabel)
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if scoreNumber > highScoreNumber
        {
            highScoreNumber = scoreNumber
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScoreLabel  = SKLabelNode(fontNamed: "Pusab")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 70
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.5)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        let restartLabel = SKLabelNode(fontNamed: "Pusab")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 75
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        restartLabel.zPosition = 1
        restartLabel.name = "restartButton"
        self.addChild(restartLabel)
        
        let exitLabel = SKLabelNode(fontNamed: "Pusab")
        exitLabel.text = "Exit"
        exitLabel.fontSize = 75
        exitLabel.fontColor = SKColor.white
        exitLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        exitLabel.zPosition = 1
        exitLabel.name = "exitButton"
        self.addChild(exitLabel)
    }
    
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let positionOfTouch = touch.location(in: self) //this was a little different
            let tappedNodes = nodes(at: positionOfTouch)   //this was different
            for tappedNode in tappedNodes
            {
                let nameOfTappedNode = tappedNode.name
                if nameOfTappedNode == "restartButton"
                {
                    self.run(clickSound)
                    let sceneToMoveTo = GameScene(size: self.size)
                        sceneToMoveTo.scaleMode = self.scaleMode
                        let sceneTransition = SKTransition.fade(withDuration: 0.2)
                        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                }
                if nameOfTappedNode == "exitButton"
                {
                    self.run(clickSound)
                    let sceneToMoveTo = MainMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let sceneTransition = SKTransition.fade(withDuration: 0.2)
                    self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                }
                
            }
        }
    }
    
}

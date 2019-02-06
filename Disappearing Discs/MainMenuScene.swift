//
//  MainMenuScene.swift
//  Disappearing Discs
//
//  Created by Austin Collier on 2/5/19.
//  Copyright © 2019 Austin Collier. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
    let clickSound = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameTitleLabel1 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel1.text = "Disappearing"
        gameTitleLabel1.fontSize = 90
        gameTitleLabel1.fontColor = SKColor.white
        gameTitleLabel1.position = CGPoint(x: self.size.width/2, y: self.size.height*0.75)
        gameTitleLabel1.zPosition = 1
        self.addChild(gameTitleLabel1)
        
        let gameTitleLabel2 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel2.text = "Discs"
        gameTitleLabel2.fontSize = 250
        gameTitleLabel2.fontColor = SKColor.white
        gameTitleLabel2.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
        gameTitleLabel2.zPosition = 1
        self.addChild(gameTitleLabel2)
        
        let gameByLabel = SKLabelNode(fontNamed: "Pusab")
        gameByLabel.text = "Team iOS Presents"
        gameByLabel.fontSize = 50
        gameByLabel.fontColor = SKColor.white
        gameByLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.95)
        gameByLabel.zPosition = 1
        self.addChild(gameByLabel)
        
        let howToLabel = SKLabelNode(fontNamed: "Pusab")
        howToLabel.text = "Tap the Discs before They Vanish"
        howToLabel.fontSize = 40
        howToLabel.fontColor = SKColor.white
        howToLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.08)
        howToLabel.zPosition = 1
        self.addChild(howToLabel)
        
        let startLabel = SKLabelNode(fontNamed: "Pusab")
        startLabel.text = "Play"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.white
        startLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.35)
        startLabel.zPosition = 1
        startLabel.name = "startButton"
        self.addChild(startLabel)
        
        let creditsLabel = SKLabelNode(fontNamed: "Pusab")
        creditsLabel.text = "ooo"
        creditsLabel.fontSize = 40
        creditsLabel.fontColor = SKColor.white
        creditsLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.04)
        creditsLabel.zPosition = 1
        self.addChild(creditsLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let positionOfTouch = touch.location(in: self) //this was a little different
            let tappedNodes = nodes(at: positionOfTouch)   //this was different
            for tappedNode in tappedNodes
            {
                let nameOfTappedNode = tappedNode.name
                if nameOfTappedNode == "startButton"
                {
                    self.run(clickSound)
                    let sceneToMoveTo = GameScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let sceneTransition = SKTransition.fade(withDuration: 0.2)
                    self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                }
            }
        }
    }
    
}

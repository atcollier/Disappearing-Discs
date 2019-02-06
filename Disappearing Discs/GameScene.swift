//
//  GameScene.swift
//  Disappearing Discs
//
//  Created by Austin Collier on 2/5/19.
//  Copyright © 2019 Austin Collier. All rights reserved.
//  TEST2

import SpriteKit
import GameplayKit
var scoreNumber = 0

class GameScene: SKScene
{
    
    let scoreLabel = SKLabelNode(fontNamed: "Pusab")
    let gameArea: CGRect
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)
    let playGameOverSoundEffect = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    
    //from 20-33 he says you just copy paste that into your code every time
    
    override init(size: CGSize)
    {
        let maxAspectRatio: CGFloat = 19.5/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: (size.height)*0.9)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max - min) + min
    }
    
    override func didMove(to view: SKView)
    {
        scoreNumber = 0
        
        let background = SKSpriteNode(imageNamed: "DiscsBackgroud")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Disc2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
        
        scoreLabel.fontSize = 250
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        self.addChild(scoreLabel)
    }
    
    func spawnNewDisc()
    {
        let randomImageNumber = (arc4random()%3) + 1
        
        let disc = SKSpriteNode(imageNamed: "Disc\(randomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        
        //This was different
        let randomX = random(min: (gameArea.minX) + disc.size.width/2,
                             max: (gameArea.maxX) - disc.size.width/2)
        let randomY = random(min: (gameArea.minY) + disc.size.height/2,
                             max: (gameArea.maxY) - disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY)
        self.addChild(disc)
        
        disc.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 3.0),
            playGameOverSoundEffect,
            SKAction.run(runGameOver)
            ]))
    }
    
    func runGameOver()
    {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
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
                if nameOfTappedNode == "discObject"
                {
                    tappedNode.name = ""
                    tappedNode.removeAllActions()
                    
                    tappedNode.run(SKAction.sequence([
                        SKAction.fadeOut(withDuration: 0.1),
                        SKAction.removeFromParent()
                        ]))
                    
                    self.run(playCorrectSoundEffect)
                    
                    spawnNewDisc()
                    scoreNumber += 1
                    scoreLabel.text = "\(scoreNumber)"
                    
                    if scoreNumber == 10 || scoreNumber == 50 || scoreNumber == 125 ||
                       scoreNumber == 300 || scoreNumber == 500
                    {
                        spawnNewDisc()
                    }
                }
            }
        }
    }

}



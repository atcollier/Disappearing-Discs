//
//  GameViewController.swift
//  Disappearing Discs
//
//  Created by Austin Collier on 2/5/19.
//  Copyright © 2019 Austin Collier. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MainMenuScene(size: CGSize(width: 2048, height: 2732))
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
        
            skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .aspectFill
        
            skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

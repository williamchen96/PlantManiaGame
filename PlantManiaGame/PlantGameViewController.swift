//
//  PlantGameViewController.swift
//  PlantManiaGame
//
//  Created by William Chen on 5/7/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PlantGameViewController: UIViewController {
    
    var wallet: Int = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            
            let scene = GameScene(size: CGSize(width: 1536, height: 2048))
            
            // Set the scale mode to scale to fit the window
            
            scene.scaleMode = .aspectFill
            
            // Present the scene
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            
            view.showsNodeCount = true
        }
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

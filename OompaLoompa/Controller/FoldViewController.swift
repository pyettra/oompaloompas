//
//  FoldViewController.swift
//  OompaLoompa
//
//  Created by Mariana Beilune Abad on 02/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit
import SpriteKit

class FoldViewController: UIViewController {
    
    var gameScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("entrou na FoldViewController")
        
        if let view = view as? SKView {

            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            gameScene = scene
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)

        }
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func proximo(_ sender: Any) {
        gameScene.animateLetter()
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

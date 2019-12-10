//
//  GameScene.swift
//  OompaLoompa
//
//  Created by Mariana Beilune Abad on 02/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    weak var parentVc: UIViewController!
    private var animation = SKSpriteNode()
    private var frames: [[SKTexture]] = []
    var animateStep = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        buildAnimation(skTexture: "dobra")
        animate(arrayFrames: frames)
        frames.removeAll()
        //limpa o array de Frames!
        buildAnimation(skTexture: "correio")
        animate(arrayFrames: frames)
        frames.removeAll()
    }
    
    func buildAnimation(skTexture: String) {
        let animatedAtlas = SKTextureAtlas(named: skTexture)
        
        for texture in animatedAtlas.textureNames.sorted() {
            let pedacos = texture.components(separatedBy: "_")
            let index = Int(pedacos[0])! - 1
            
            if frames.count > index {
                frames[index].append(animatedAtlas.textureNamed(texture))
            } else {
                frames.append([animatedAtlas.textureNamed(texture)])
            }
        }
        
        let firstFrameTexture = frames[0][0]
        animation = SKSpriteNode(texture: firstFrameTexture)
        animation.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(animation)
    }
    
    func animate(arrayFrames: [[SKTexture]]) {
        if animateStep < arrayFrames.count {
            animation.run(
                SKAction.animate(with: arrayFrames[animateStep],
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: false))
            animateStep += 1
        } else {
            print("acabou a animação")
        }
        
        //tem que fazer o som.
    }
    
    func nextStep(animateStep: Int) {
        animate(arrayFrames: frames)
    }
    
    func popToChildrenScreen() {
        self.parentVc.performSegue(withIdentifier: "unwindSegue", sender: self.parentVc)
    }
    
    
    func selectSound() -> String {
        var sounds = ["dobra1.wav", "dobra2.wav", "dobra3.wav"]
        return sounds.randomElement()!
    }
}


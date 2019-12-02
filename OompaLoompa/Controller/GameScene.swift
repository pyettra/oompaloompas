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
    
    private var letter = SKSpriteNode()
    private var foldLetterFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
      backgroundColor = .blue
        animateLetter()
    }
    
    func buildLetter() {
      let letterAnimatedAtlas = SKTextureAtlas(named: "Dobra")
      var foldFrames: [SKTexture] = []

      let numImages = letterAnimatedAtlas.textureNames.count
      for i in 1...numImages {
        let bearTextureName = "bear\(i)"
        foldFrames.append(letterAnimatedAtlas.textureNamed(bearTextureName))
      }
      foldLetterFrames = foldFrames
        
        let firstFrameTexture = foldLetterFrames[0]
        letter = SKSpriteNode(texture: firstFrameTexture)
        letter.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(letter)
        
        buildLetter()
    }
    
    func animateLetter() {
      letter.run(SKAction.repeatForever(
        SKAction.animate(with: foldLetterFrames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
        withKey:"walkingInPlaceBear")
    }
}


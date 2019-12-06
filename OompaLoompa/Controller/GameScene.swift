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
    private var foldLetterFrames: [[SKTexture]] = []
    var animateStep = 0
    
    override func didMove(to view: SKView) {
      backgroundColor = .white
        buildLetter()
        animateLetter()
    }
    
    func buildLetter() {
      let letterAnimatedAtlas = SKTextureAtlas(named: "dobra")

        for texture in letterAnimatedAtlas.textureNames.sorted() {
        //quebra o nome em partes, o que tiver antes do _ é o passo e o que tiver depois é o frame.
            let pedacos = texture.components(separatedBy: "_")
            let index = Int(pedacos[0])! - 1 //qual pedaço da animação vai tocar
            
            if foldLetterFrames.count > index  {
                foldLetterFrames[index].append(letterAnimatedAtlas.textureNamed(texture))
            } else {
                foldLetterFrames.append([letterAnimatedAtlas.textureNamed(texture)])
            }
      }
     
            let firstFrameTexture = foldLetterFrames[0][0]
        letter = SKSpriteNode(texture: firstFrameTexture)
        letter.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(letter)

    }
    
    func animateLetter() {
        if animateStep < foldLetterFrames.count {
            letter.run(
            SKAction.animate(with: foldLetterFrames[animateStep],
                             timePerFrame: 0.6,
                             resize: false,
                             restore: false))
//            var sfxFold1 = CustomAudioPlayer(fileName: "dobra1.wav")
//            sfxFold1.play()
            let sound = selectSound()
            let sfxFold = SKAction.playSoundFileNamed(sound, waitForCompletion: false)
            run(sfxFold)
            print("tocou o som")
            animateStep += 1
        } else {
            print("acabou a dobradura")
        }
    }
    
    
    func selectSound() -> String {
        var sounds = ["dobra1.wav", "dobra2.wav", "dobra3.wav"]
        return sounds.randomElement()!
    }
}


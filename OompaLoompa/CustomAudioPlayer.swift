//
//  CustomAudioPlayer.swift
//  OompaLoompa
//
//  Created by Mariana Beilune Abad on 05/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import AVFoundation

class CustomAudioPlayer {
    
    private var players = [AVAudioPlayer]()
    private var url: URL!
    
    init(fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        url = URL(fileURLWithPath: path)
        load()
    }
    
    private func load() {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            players.append(player)
        } catch {
            print("O arquivo não foi encontrado")
        }
    }
    
    func play() {
        for player in players {
            if player.isPlaying == false {
                player.play()
                return
            }
        }
        load()
        players.last?.play()
    }
}

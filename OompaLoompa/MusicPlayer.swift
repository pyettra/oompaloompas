//
//  MusicPlayer.swift
//  OompaLoompa
//
//  Created by Mariana Beilune Abad on 05/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
//
//  MusicPlayer.swift
//  Workshop-Som
//
//  Created by Mariana Beilune Abad on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    
    static var shared = MusicPlayer()
    private var musics = [Song: Music]()
    
    private init() {
        musics[.one] = Music(fileName: "musica1.wav")
        musics[.two] = Music(fileName: "musica2.wav")
        musics[.three] = Music(fileName: "musica3.wav")
    }
    
    func play(_ songToPlay: Song) {
        for (song, music) in musics {
            if song == songToPlay {
                music.play()
            } else {
                music.stop()
                print("acabou a música?")
            }
        }
    }
}

enum Song {
    case one
    case two
    case three
}

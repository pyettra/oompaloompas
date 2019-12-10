//
//  PlayerViewController.swift
//  testDraw
//
//  Created by Lucas Ronnau on 06/12/19.
//  Copyright © 2019 Lucas Ronnau. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFileName: URL!
    
    var model = Model.instance
    
    var path: URL!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //path = model.children[0].letters[0].url

        // Do any additional setup after loading the view.
        
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission{
                print("ACCEPTED")
            }
        }
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            // failed to record!
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        
        do {
            try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch {
            print("arquivo não encontrado")
        }
        
        
    }
    
    @IBAction func pauseAudio(_ sender: Any) {
        
        do {
            audioPlayer.pause()
        } catch {
            print("arquivo não encontrado")
        }
        
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

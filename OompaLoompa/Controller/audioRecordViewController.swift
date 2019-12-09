//
//  recordAudioViewController.swift
//  testDraw
//
//  Created by Lucas Ronnau on 05/12/19.
//  Copyright © 2019 Lucas Ronnau. All rights reserved.
//

import UIKit
import AVFoundation

class recordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    
    var model = Model.instance
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFileName: URL!
    
    
    @IBOutlet weak var imgRecorderAudio: UIImageView!
    @IBOutlet weak var imgPlayAndPause: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        // permissão do usuário para usar o microfone
        
        model.number = 0

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            // failed to record!
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder == nil {
            imgRecorderAudio.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            startRecording()
        } else {
            imgRecorderAudio.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            finishRecording(success: true)
        }
    }
    
    @IBAction func playAndStopAudio(_ sender: Any) {
        
        do {
            try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        //aqui ele dá play no áudio
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            audioPlayer.play()
        } catch {
            print("arquivo não encontrado")
        }
    }
    
    @IBAction func sendAudio(_ sender: Any) {
        
        let letter: Letters = Letters(url: audioFileName, type: .audio)
        model.children[0].letters.append(letter)
//        do {
//            audioFileName.dataRepresentation.write(to: filename)
//        }
        
    }
    
    
    func startRecording() {
        // onde o áudio fica salvo
        audioFileName = model.getDirectory().appendingPathComponent("teste.m4a")

        // configurações do áudio
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        //iniciar gravação

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            print("recording success :)")
        } else {
            print("recording failed :(")
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
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

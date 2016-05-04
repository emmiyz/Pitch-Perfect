//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Emily Zhao on 1/31/16.
//  Copyright © 2016 Emily Zhao. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer2 = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopAndRestartAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func audioRate(rate: Float) {
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    @IBAction func PlaySlowAudio(sender: UIButton) {
        // Play audio slowly here
        stopAndRestartAudio()
        audioRate(0.5)
    }

    @IBAction func PlayFastAudio(sender: UIButton) {
        // Play audio fast here
        stopAndRestartAudio()
        audioRate(1.5)
        
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAndRestartAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect,to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func StopAudio(sender: UIButton) {
        // Stops audio
        stopAndRestartAudio()
    }
    
    
    
    @IBAction func playEchoAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        audioPlayer2.playAtTime(playtime)
    }
    }



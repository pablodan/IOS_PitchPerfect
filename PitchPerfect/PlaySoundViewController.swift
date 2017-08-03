//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Paul Omeally on 7/24/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    

    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipMunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundButton(_ sender: UIButton){
  
        
        switch(ButtonType(rawValue: sender.tag)!){
            
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipMunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
        
        
    @IBAction func stopPLayingAudio(_ sender: Any) {
        stopAudio()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

       setupAudio()
       //setup ui
       updatePlayButtons()
    }
    
    func updatePlayButtons()
    {
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //setup UI
        configureUI(.notPlaying)
    }
    
    
    
  


}

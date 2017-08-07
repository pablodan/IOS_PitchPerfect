//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Paul Omeally on 7/23/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    

    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    let stopMsg = "Tap to record"
    let playMsg  = "Recording"
    
    //create instance of AVAudioRecorder
    var audioRecorder: AVAudioRecorder!
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //disable stop recording button and update label
        updateRecUi(isRecording: false, recordTxt: stopMsg)
    }
    

    
    @IBAction func recordAudio(_ sender: Any)
    {
        updateRecUi(isRecording: true, recordTxt: playMsg)
        
        //************Record Audio****************
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    

    @IBAction func stopRecording(_ sender: Any) {
        
        //recordButton.isEnabled = true
       // stopRecordingButton.isEnabled = false
        updateRecUi(isRecording: false, recordTxt: stopMsg)

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       
        if flag {
           performSegue(withIdentifier: "stopRecordingSeg", sender: audioRecorder.url)
        }
        else {
            let errDialog = UIAlertController(title: "Error!", message: "Their was an error in the recording!", preferredStyle: .alert)
            
            present(errDialog, animated: true
                , completion: nil)
            
        }
    }
    
    //update ui on record view
    func updateRecUi(isRecording: Bool, recordTxt: String){
        
        if isRecording == true {
            
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            recordLabel.text = recordTxt
         
        }
        else if isRecording == false {
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            recordLabel.text = recordTxt
  
        }
       
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSeg" {
           let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordAudioURL
        }
    }
}




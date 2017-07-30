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
    
    //create instance of AVAudioRecorder
    var audioRecorder: AVAudioRecorder!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("Hello now")
        //disable stop recording button
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("View will appear called!")
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func RecordAudio(_ sender: Any)
    {
       //print("Record button was pressed!")
        //recordLabel.text = "Recording in Progress.."
  
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        //************Record Audio****************
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //print("File Path \(filePath)")
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    

    @IBAction func StopRecording(_ sender: Any) {
        //print("Stop recording..")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordLabel.text = "Tap to Record.."
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       
        //print("finished recording! ")
        if flag {
           performSegue(withIdentifier: "stopRecordingSeg", sender: audioRecorder.url)
        }
        else {
            let errDialog = UIAlertController(title: "Error!", message: "Their was an error in the recording!", preferredStyle: .alert)
            
            present(errDialog, animated: true
                , completion: nil)
             //print("recording was not successful!")
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


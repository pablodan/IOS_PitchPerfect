//
//  RecordSoundVCNavigation.swift
//  PitchPerfect
//
//  Created by Paul Omeally on 8/2/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//
import UIKit

extension RecordSoundViewController {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSeg" {
            let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordAudioURL
        }
    }

}

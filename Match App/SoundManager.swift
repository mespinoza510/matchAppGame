//
//  SoundManager.swift
//  Match App
//
//  Created by Marco Espinoza on 10/25/19.
//  Copyright © 2019 Marco Espinoza. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {

    static var audioPlayer: AVAudioPlayer?
    static var soundFilename: String?
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    static func playSound(_ effect: SoundEffect) {
        
        // Determine cases for sound effects
        switch effect {
            case .flip:
                soundFilename = "cardflip"
            case .match:
                soundFilename = "dingcorrect"
            case .nomatch:
                soundFilename = "dingwrong"
            case .shuffle:
                soundFilename = "shuffle"
        }
        
        // Get path to the sound file in bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        guard bundlePath != nil else {
            print("Not able to find filename: \(String(describing: soundFilename)) in the bundle.")
            return
        }
        
        // Create URL object from string path
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        
        do {
            
            // Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        }
        catch {
            
            // Error handling: couldn't create audio player object
            print("Coudn't create the audio player object sound file \(String(describing: soundFilename))")
        }
    }
    
}


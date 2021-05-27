//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    let eggTimes = ["Soft":10, "Medium":15, "Hard":20]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var audio:AVPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self]
                    (Timer) in
                        if secondsPassed < totalTime {
                            self.secondsPassed += 1
                            let percentageProgress = Float(secondsPassed) / Float(totalTime)
                            progressBar.progress = percentageProgress
                            self.titleLabel.text = "\(secondsPassed) seconds"
                            
                        } else {
                            Timer.invalidate()
                            self.titleLabel.text = "DONE!"
                            playAlarm()
                        }
                }
    
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        audio = AVPlayer.init(url: url!)
        
        audio.play()
    }
}

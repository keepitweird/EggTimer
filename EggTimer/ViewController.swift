//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.

//  Enhanced by Tina Ho in October 2021.
//  New features include: Reset button, Sound Test button, Count down timer label, and more.


import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countDownTimerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720] //In seconds
    //let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7] //For quick testing, less wait time (in seconds)
    var timer = Timer() //Timer lives outside so that it can be stopped
    var player: AVAudioPlayer?
    
    @IBAction func hardnessPressed(_ sender: UIButton) {
        var totalTime = 0
        timer.invalidate() //Just in case this button is tapped multiple times
        player?.stop() //Stop alert sound
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness] ?? 0
        
        titleLabel.text = hardness + "\n(\(totalTime) seconds in total)"
        countDownTimerLabel.text = "\(totalTime)" //Show total time
        var remainingTime = totalTime
        
        //Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 1 { remainingTime -= 1 }
            else if remainingTime == 1 {
                remainingTime -= 1
                self.titleLabel.text = "Done!"
                self.playSound()
            }
            else { self.timer.invalidate() }
            
            self.progressBar.progress = Float(totalTime - remainingTime) / Float(totalTime)
            self.countDownTimerLabel.text = "\(remainingTime)"
        }
    }
    
    @IBAction func soundTestButton(_ sender: UIButton) {
        playSound()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate() //User wants to cancel timer
        player?.stop() //Stop alert sound
        self.titleLabel.text = "How do you like your eggs?"
        self.progressBar.progress = 0
        self.countDownTimerLabel.text = "0"
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}

//
//  ViewController.swift
//  MoveMeterStudio
//
//  Created by Vidur Satija on 19/03/16.
//  Copyright © 2016 Aromatic Studios. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    //NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    @IBOutlet weak var songPath: NSTextField!
    
    var timer:NSTimer!
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func playSong(sender: AnyObject){
        print(songPath.stringValue)
        _ = "file://localhost"+songPath.stringValue
        let path = NSURL(fileURLWithPath: songPath.stringValue)
        let url = path
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer.meteringEnabled = true
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        } catch {
            // couldn't load file :(
            print("Error")
        }
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: "F", userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseSong(sender: AnyObject)
    {
        audioPlayer.stop()
        timer.invalidate()
    }
    
    func F(){
        
        var scale = Float(0.5)
        audioPlayer.updateMeters()
        var power = Float(0.0)
        
        for i in  0..<audioPlayer.numberOfChannels {
            power = power + audioPlayer.averagePowerForChannel(i)
        }
        
        power = power / Float(audioPlayer.numberOfChannels)
        let level = MeterTable.ValueAt(power)
        scale = level * 255
        MeterTable.updateTracker(scale)

    }


}


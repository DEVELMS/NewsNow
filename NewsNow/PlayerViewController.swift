//
//  PlayerViewController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 06/11/16.
//
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {
    
    private var state = State.paused
    var video: Video?
    
    private enum State {
    
        case playing
        case paused
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        doAction()
    }
    
    func changeVideo(video: Video) {
    
        self.video = video
        doAction()
    }
    
    private func play(url: String) {
    
        let videoURL = NSURL(string: url)
        self.player = AVPlayer(url: videoURL! as URL)
        
        guard let player = self.player else {
            print("invalid url to player")
            return
        }
        
        player.play()
    }
    
    private func pause() {
    
        guard let player = self.player else {
            return
        }
        
        player.pause()
    }
    
    private func doAction() {
        
        guard let video = video else {
            print("video cannot be null")
            return
        }
        
        switch state {
        case .playing:
            state = .paused
            pause()
        case .paused:
            state = .playing
            play(url: video.url)
        }
        
        print(state)
    }
    
    deinit { self.player = nil }

}

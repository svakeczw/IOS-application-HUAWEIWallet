//
//  SplashViewController.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController {
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false

    @IBAction func startPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "introduced")
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        playVideo()
        //super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func playVideo() {
        //let theURL = Bundle.main.url(forResource: "HomePageVideo", withExtension: "mp4")
        let theURL = Bundle.main.url(forResource: "HomePageVideo", withExtension: "mp4")
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)

        // set observer for UIApplicationWillEnterForeground
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let player = notification.object as? AVPlayerItem {
            //player.seek(to: CMTime.zero)
            player.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
    @objc func willEnterForeground() {
           if self.viewIfLoaded?.window != nil {
               avPlayer.play()
               paused = false
           }
       }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play()
        paused = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

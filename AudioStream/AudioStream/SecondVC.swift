//
//  SecondVC.swift
//  AudioStream
//
//  Created by LinhND on 10/4/18.
//  Copyright © 2018 LinhND. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import SwiftWebSocket
import AVKit

class SecondVC: UIViewController, YTPlayerViewDelegate {
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    var socket: WebSocket? // WebSocket("ws://demos.kaazing.com/echo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ytPlayerView.delegate = self
        let playVar = ["playsinline" : 1, "controls": 0, "loop": 1, "autoplay": 0, "playlist": "QPDX91iJ_RA"] as [String : Any]
//        ytPlayerView.load(withVideoId: "QPDX91iJ_RA")
        ytPlayerView.load(withVideoId: "QPDX91iJ_RA", playerVars: playVar)
        self.socket = WebSocket("ws://demos.kaazing.com/echo")
        // Do any additional setup after loading the view.
        
        let videoURL = URL(string: "http://stream.radioreklama.bg/radio1.opus")
        let player = AVPlayer(url: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        player.play()
        
        socket?.event.open = {
            print("opened")
        }

        socket?.event.close = { code, reason, clean in
            print("closed")
        }

        socket?.event.error = { error in
            print("error \(error)")
        }

        socket?.event.message = { message in
            if let text = message as? String {
                self.handleMessage(jsonString: text)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleMessage(jsonString:String){
        if let data = jsonString.data(using: String.Encoding.utf8){
            do {
                let JSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print("We've successfully parsed the message into a Dictionary! Yay!\n\(JSON)")
            } catch let error{
                print("Error parsing json: \(error)")
            }
        }
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
//        switch state {
//        case .:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

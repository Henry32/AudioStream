//
//  SecondVC.swift
//  AudioStream
//
//  Created by LinhND on 10/4/18.
//  Copyright © 2018 LinhND. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
//import SwiftWebSocket
import AVFoundation
import OGVKit
import SocketIO

class SecondVC: UIViewController, YTPlayerViewDelegate, OGVPlayerDelegate {
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
//    var socket: WebSocket? // WebSocket("ws://demos.kaazing.com/echo")
    var player: AVPlayer?
    var avPlayerItem:AVPlayerItem?
    var ogplayer: OGVPlayerView?
//    let socket = SocketIOClient(manager: <#T##SocketManagerSpec#>, nsp: <#T##String#>)
    let manager = SocketManager(socketURL: URL(string: "wss://echo.websocket.org")!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ytPlayerView.delegate = self
        
        let playVar = ["playsinline" : 1, "controls": 0, "loop": 1, "autoplay": 0, "playlist": "QPDX91iJ_RA"] as [String : Any]
//        ytPlayerView.load(withVideoId: "QPDX91iJ_RA")
        // Do any additional setup after loading the view.
        
//        let socket = manager.defaultSocket
        
//        let socketManagerSpec = SocketManagerSpec(
//        let socket = SocketIOClient(
//        let socket = SocketIOClient(manager: SocketManagerSpec, nsp: <#T##String#>)
        let socket = self.manager.defaultSocket
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            print("socket error")
        }
        
        socket.on(clientEvent: .ping) { (data, ack) in
            print("socket data %@", data)
        }
        
        
        socket.on("gameover") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                socket.emit("update", ["amount": cur + 2.50])
            }
            
            ack.with("Got your currentAmount", "dude")
        }
        
        
        // Using a shorthand parameter name for closures
//        self.socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}

//        socket.co
        
        socket.connect()
//        socket.emit("haha", with: [2])
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            print("AVAudioSession Category Playback OK")
//            do {
//                try AVAudioSession.sharedInstance().setActive(true)
//                print("AVAudioSession is Active")
//
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
        
//        let playerLayer = AVPlayerLayer(player: player)
//
        
        DispatchQueue.main.async { [weak self] in
//            self?.ytPlayerView.load(withVideoId: "QPDX91iJ_RA", playerVars: playVar)
//            self?.socket = WebSocket("ws://demos.kaazing.com/echo")
//            self?.socket = WebSocket("ws://achex.ca:4010")
//            let videoURL = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
//            let videoURL = URL(string: "http://stream.radioreklama.bg/radio1.opus")
//            self?.avPlayerItem = AVPlayerItem.init(url: videoURL! as URL)
//            self?.player = AVPlayer(playerItem: self?.avPlayerItem)
//            self?.player?.volume = 1.0
//            self?.player?.rate = 1.0
//            self?.player?.play()
            
//            self?.ogplayer = OGVPlayerView(frame: CGRect.init())
//            self?.ogplayer?.delegate = self
//            self?.ogplayer?.sourceURL = URL(string: "http://stream.radioreklama.bg/radio1.opus")
            
        }
        
//        socket?.event.open = {
//            print("opened")
//        }
//
//        socket?.event.close = { code, reason, clean in
//            print("closed")
//        }
//
//        socket?.event.error = { error in
//            print("error \(error)")
//        }
//
//        socket?.event.message = { message in
//            if let text = message as? String {
//                self.handleMessage(jsonString: text)
//            }
//        }
//        socket?.compression.on = true
//        socket?.allowSelfSignedSSL = true
//        socket?.open("ws://demos.kaazing.com/echo")
    }
    
    func ogvPlayerDidPlay(_ sender: OGVPlayerView!) {
        print("shit -----------")
    }
    
    func ogvPlayerDidLoadMetadata(_ sender: OGVPlayerView!) {
        print("did load meta ")
//        ogplayer?.play()
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
//        playerView.playVideo()
    }
}

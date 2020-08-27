//
//  LoginMovieViewController.swift
//  Swift5IntroApp01
//
//  Created by 中塚富士雄 on 2020/08/27.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import AVFoundation


class LoginMovieViewController: UIViewController {

    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "start", ofType: "mov")
        
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        
        //AVPlayer用のlayerを生成
        let playerLayer = AVPlayerLayer(player:player)
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        playerLayer.videoGravity = .resizeAspectFill
        //無限ループのための設定1
        playerLayer.repeatCount = 0
        //ログインボタンを上に持ってくる
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        //無限ループのための設定２(クロージャー、Endまできたら、時間＝0：開始のポイントを探す)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object:player.currentItem, queue:  .main){ (_) in
            
            self.player.seek(to: .zero)
            self.player.play()
         
            self.player.play()
            
    
        }

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
    //🌷Boolなのに、なぜ"animated"(true/falseではない)？⭐️
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        player.pause()
        
    }
    

}

//
//  Video.swift
//  sample
//
//  Created by Adityapal Waraich on 2024-05-01.
//

import SwiftUI
import AVKit

struct VideoBackgroundView1: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        guard let url = Bundle.main.url(forResource: "Night", withExtension: "mov")
            
        else {
            return view
        }
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
    
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.repeatCount = .infinity // Loop the video
        
        view.layer.addSublayer(playerLayer)
        
        player.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
struct VideoBackgroundView2: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        guard let url = Bundle.main.url(forResource: "bbb", withExtension: "mp4")
            
        else {
            return view
        }
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
    
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.repeatCount = .infinity // Loop the video
        
        view.layer.addSublayer(playerLayer)
        
        player.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}



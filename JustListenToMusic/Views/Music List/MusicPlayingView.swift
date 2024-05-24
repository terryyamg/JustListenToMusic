//
//  MusicPlayingView.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/29.
//

import SwiftUI
import Lottie

struct MusicPlayingView: UIViewRepresentable {
    var name = ""
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: UIViewRepresentableContext<MusicPlayingView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

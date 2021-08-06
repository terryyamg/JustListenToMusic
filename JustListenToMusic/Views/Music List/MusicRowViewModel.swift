//
//  MusicRowViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/21.
//

import AVFoundation

class MusicRowViewModel: NSObject, ObservableObject {
    static var avQueuePlayer: AVQueuePlayer?
    static var avAudioPlayer: AVAudioPlayer?
    var soundFiles: [String] = []

    init(soundFiles: [String]) {
        self.soundFiles = soundFiles
    }

    private func initSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("initSession error")
        }
    }

    func playSounds(_ soundFile: String) {
        if let url = Bundle.main.url(forResource: soundFile, withExtension: "mp3") {
            do {
                initSession()
                MusicRowViewModel.avAudioPlayer = try AVAudioPlayer(contentsOf: url)
                MusicRowViewModel.avAudioPlayer?.delegate = self
                MusicRowViewModel.avAudioPlayer?.prepareToPlay()
                MusicRowViewModel.avAudioPlayer?.play()
            } catch {
                print("playSounds error")
            }
        }
    }

    func playLoop(_ soundFile: String) -> AVPlayerLooper? {
        initSession()
        guard let url = Bundle.main.url(forResource: soundFile, withExtension: "mp3") else {
            return nil
        }
        MusicRowViewModel.avQueuePlayer = AVQueuePlayer()
        let item = AVPlayerItem(url: url)
        guard let player = MusicRowViewModel.avQueuePlayer else {
            return nil
        }

        return AVPlayerLooper(player: player, templateItem: item)
    }
    func stopAll() {
        MusicRowViewModel.avAudioPlayer?.stop()
        MusicRowViewModel.avQueuePlayer?.pause()
    }
}

extension MusicRowViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

        guard let firstFile = soundFiles.first else {
            return
        }
        soundFiles.removeFirst()
        soundFiles.append(firstFile)
        
        guard let soundFile = soundFiles.first else {
            return
        }
        playSounds(soundFile)
    }
}

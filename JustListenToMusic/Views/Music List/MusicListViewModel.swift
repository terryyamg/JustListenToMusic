//
//  MusicListViewModel.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation

class MusicListViewModel: ObservableObject {
    @Published private(set) var musicList: [MusicData] = []

    init(_ musicList: [MusicData]) {
        self.musicList = musicList
    }
}

//
//  MusicData.swift
//  JustListenToMusic
//
//  Created by 楊鎮齊 on 2021/7/22.
//

import Foundation

enum MusicType: String, CaseIterable {
    case japan = "日文"
    case chinese = "國語"
    case game = "遊戲"
}

struct MusicData: Identifiable {
    var id: Int
    var type: MusicType
    var title: String
}
